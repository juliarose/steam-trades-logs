module Profit
  
  def self.market
    charlotte = "76561198137909800"
    after_date = 1.month.ago
    
    SteamTrade
    .non_bot
    .includes(:steam_trade_items => :item)
    .where(:steamid => charlotte)
    .where("traded_at >= ?", after_date)
    .to_a
  end
  
  def self.check(begin_date, end_date, owner = "76561198080179568")
    bot_ids = BotOwnership.where(:steamid => owner).map(&:bot_id)
    bot_steamid_ids = Bot.where(:id => bot_ids).map(&:uid)
    rejected_steamids = (BOTS + BotOwnership.unique_owners).uniq
    cash_trade_steam_trade_ids = CashTrade.all.map(&:steam_trade_id).uniq.compact
    
    purchases_steam_trade_items = SteamTradeItem
      .joins(:steam_trade)
      .includes(:steam_trade)
      .where(
        "steam_trades.steamid IN (?) AND " +
        "steam_trades.steamid_other NOT IN (?) AND " +
        "steam_trades.traded_at >= ? AND " +
        "steam_trades.traded_at < ? AND " +
        "steam_trade_id NOT IN (?) AND " +
        "is_their_item = TRUE AND " +
        "quality_id = 5",
        bot_steamid_ids,
        rejected_steamids,
        begin_date,
        end_date,
        cash_trade_steam_trade_ids
      )
    purchases_market_listings = MarketListing
      .where(
        "date_acted >= ? AND " +
        "date_acted < ? AND " +
        "quality_id = 5 AND " +
        "particle_id IS NOT NULL AND " +
        "is_credit = FALSE",
        begin_date,
        end_date
      )
    
    sales_marketplace_items = MarketplaceSaleItem
      .joins(:marketplace_sale)
      .includes(:marketplace_sale)
      .where(
        "marketplace_sales.date >= ? AND " +
        "particle_id IS NOT NULL",
        begin_date
      )
    sales_market_listings = MarketListing
      .where(
        "date_acted >= ? AND " +
        "appid = 440 AND " +
        "quality_id = 5 AND " +
        "particle_id IS NOT NULL AND " +
        "is_credit = TRUE",
        begin_date
      )
    sales_steam_trade_items = SteamTradeItem
      .joins(:steam_trade)
      .includes(:steam_trade)
      .where(
        "steam_trades.steamid IN (?) AND " +
        "steam_trades.steamid_other NOT IN (?) AND " +
        "steam_trades.traded_at >= ? AND " +
        "is_their_item = FALSE AND " +
        "quality_id = 5",
        bot_steamid_ids,
        rejected_steamids,
        begin_date
      )
    
    purchases = [
      purchases_steam_trade_items,
      purchases_market_listings
    ].flatten
    sales = [
      sales_marketplace_items,
      sales_market_listings,
      sales_steam_trade_items
    ].flatten
    
    grouped_sales = sales.group_by(&:log_name)
    
    steam_trades = [
      purchases_steam_trade_items,
      sales_steam_trade_items
    ].flatten.map(&:steam_trade)
    
    # will preload all items associated with the associated trades
    preloader = ActiveRecord::Associations::Preloader.new
    preloader.preload(steam_trades, :steam_trade_items)
    
    profits = Array.new
    
    purchases.each_with_index do |purchase, i|
      name = purchase.log_name
      sale = self.sale_value(purchase, purchases.clone[i..-1], grouped_sales)
      
      unless sale.nil?
        sale[:name] = name
        profits.push(sale)
      end
    end
    
    puts purchases.length
    
    File.open("/home/colors/js/profit/items.json", "w") do |f|
      f.write({ :sales => profits }.to_json)
    end
  end
  
  def self.sale_value(purchase, purchases, grouped_sales)
    if purchase.is_a? SteamTradeItem
      return self.steam_trade_item_sale_value(purchase, purchases, grouped_sales)
    elsif purchase.is_a? MarketListing
      scm_value = ScmValue.find_by_date(purchase.date_acted).value
      
      if purchase.is_credit
        return purchase.price / scm_value.to_f
      else
        # we want to get the sale value for this
        sale = self.get_sale_for(purchase, grouped_sales)
        
        if sale
          sale_value = self.sale_value(sale, purchases, grouped_sales)
          gained = sale_value.is_a?(Float) ? sale_value : sale_value[:profit]
          lost = purchase.price / scm_value.to_f
          total = gained - lost
          
          return {
            :lost => lost,
            :gained => gained,
            :estimated => false,
            :sale_items => [sale],
            :item => purchase,
            :profit => total
          }
        else
          gained = (purchase.price * 1.22) / scm_value
          lost = purchase.price.to_f / scm_value
          total = gained - lost
          
          return {
            :lost => lost,
            :gained => gained,
            :estimated => true,
            :item => purchase,
            :profit => total
          }
        end
      end
    elsif purchase.is_a? MarketplaceSaleItem
      usd_value = UsdValue.find_by_date(purchase.marketplace_sale.date).value
      
      return (purchase.price * 0.9) / usd_value
    end
    
    0
  end
  
  def self.get_sale_for(item, grouped_sales)
    log_name = item.log_name
    
    sales = grouped_sales[log_name]
    
    if sales.nil?
      return nil
    end
    
    sales = sales.select do |sale|
      sale.sold_at >= (item.sold_at - 86400)
    end
    
    # takes the first sale and removes it
    sale = sales.first
    grouped_sales[log_name].delete(sale)
    
    sale
  end
  
  def self.steam_trade_item_sale_value_for(steam_trade_item, purchases, grouped_sales)
    sale = self.get_sale_for(steam_trade_item, grouped_sales)
    
    if sale.nil?
      return nil
    end
    
    sale_value = self.sale_value(sale, purchases, grouped_sales)
    
    if sale_value.is_a?(Float)
      # this is fine
      return {
        :sale => sale,
        :value => sale_value
      }
    end
    
    return {
      :sale => sale,
      :value => sale_value[:profit]
    }
  end
  
  def self.purchase_value(steam_trade)
    steam_trade_items = steam_trade.steam_trade_items
    my_items, them_items = steam_trade_items.partition(&:is_their_item)
    unusuals = my_items.filter { |steam_trade_item| steam_trade_item.quality_id == 5 }
    
    # by wepaons
    metal_divisions = 18
    
    # our value for keys
    key_value = (KeyValue.find_by_date(steam_trade.traded_at).value * metal_divisions).to_i
    
    # for storing total values in keys
    totals = {
      :my => 0,
      :them => 0
    }
    
    totals_metal = {
      :my => 0,
      :them => 0
    }
    
    steam_trade_items.each do |steam_trade_item|
      # whos item is this?
      who = steam_trade_item.is_their_item ? :them : :my
      value = 0
      metal_value = 0
      
      is_unusual = unusuals.any? do |unusual|
        steam_trade_item == unusual
      end
      
      if is_unusual
        # skip it!
        next
      end
      
      case steam_trade_item.item_name
      when "Mann Co. Supply Crate Key"
        value = 1
      when "Refined Metal"
        metal_value = 9 * (metal_divisions / 9)
      when "Reclaimed Metal"
        metal_value = 3 * (metal_divisions / 9)
      when "Scrap Metal"
        metal_value = 1 * (metal_divisions / 9)
      end
      
      totals[who] += value
      totals_metal[who] += metal_value
    end
    
    # add the metal totals to the total
    totals[:my] += totals_metal[:my] / key_value.to_f
    totals[:them] += totals_metal[:them] / key_value.to_f
    
    # the total is my total, minus their total
    total = totals[:my] - totals[:them]
    
    # if the total does not have value this is not a purchase
    unless total > 0
      return nil
    end
    
    # return the items purchased and the total value of the purchase
    {
      :date => steam_trade.traded_at,
      :items => unusuals.map(&:log_name),
      :total => totals[:my]
    }
  end
  
  def self.purchases_json(steam_trades)
    # sort them
    steam_trades = steam_trades.sort_by do |steam_trade|
      steam_trade.traded_at.to_i * -1
    end
    
    # get purchase details
    purchases = steam_trades.map do |steam_trade|
      Profit.purchase_value(steam_trade)
    end
    
    # remove empty values
    purchases = purchases.select do |purchase|
      !!purchase
    end
    
    puts purchases
    
    File.open("/home/colors/purchases.json", "w") do |f|
      f.write({ :purchases => purchases }.to_json)
    end
  end
  
  def self.steam_trade_item_sale_value(steam_trade_item, purchases, grouped_sales)
    steam_trade = steam_trade_item.steam_trade
    
    # by wepaons
    metal_divisions = 18
    
    # our value for keys
    key_value = (KeyValue.find_by_date(steam_trade.traded_at).value * metal_divisions).to_i
    
    # for storing total values in keys
    totals = {
      :my => 0,
      :them => 0
    }
    
    totals_metal = {
      :my => 0,
      :them => 0
    }
    
    # the origin for this sale
    origin_item = steam_trade_item
    unused = Array.new
    unused_on_their_side = Array.new
    sale_items = Array.new
    
    steam_trade.steam_trade_items.each do |steam_trade_item|
      # whos item is this?
      who = steam_trade_item.is_their_item ? :them : :my
      value = 0
      metal_value = 0
      
      if steam_trade_item == origin_item
        if !steam_trade_item.is_their_item
          # skip it!
          next
        end
        
        # we want to know what we sold this for
        sale = self.steam_trade_item_sale_value_for(steam_trade_item, purchases, grouped_sales)
        
        if sale.nil?
          unused.push(steam_trade_item)
        else
          sale_items.push(sale[:sale])
          value = sale[:value]
        end
      end
      
      case steam_trade_item.item_name
      when "Mann Co. Supply Crate Key"
        value = 1
      when "Refined Metal"
        metal_value = 9 * (metal_divisions / 9)
      when "Reclaimed Metal"
        metal_value = 3 * (metal_divisions / 9)
      when "Scrap Metal"
        metal_value = 1 * (metal_divisions / 9)
      end
      
      if value.zero? && metal_value.zero?
        if steam_trade_item.particle_id && !steam_trade_item.is_their_item
          # we want to know what we sold this for
          sale = self.steam_trade_item_sale_value_for(steam_trade_item, purchases, grouped_sales)
          
          if sale.nil?
            unused.push(steam_trade_item)
          else
            sale_items.push(sale[:sale])
            value = sale[:value]
          end
        elsif steam_trade_item.particle_id && steam_trade_item.is_their_item
          # this trade includes another purchase...
          purchase = purchases.find do |purchase|
            purchase == steam_trade_item
          end
          
          # we no longer need this
          purchases.delete(purchase) if purchase
          
          # we want to know what we sold this for
          sale = self.steam_trade_item_sale_value_for(steam_trade_item, purchases, grouped_sales)
          
          if sale.nil?
            unused_on_their_side.push(steam_trade_item)
          else
            sale_items.push(sale[:sale])
            value = sale[:value]
          end
        else
          # otherwise use the bp.tf price as for the value
          bptf_price = steam_trade_item.bptf_price
          
          if bptf_price
            if bptf_price.currency == "metal"
              metal_value = (bptf_price.value * metal_divisions).round.to_i
            else
              value = bptf_price.value
            end
          end
        end
      end
      
      totals[who] += value
      totals_metal[who] += metal_value
    end
    
    # add the metal totals to the total
    totals[:my] += totals_metal[:my] / key_value.to_f
    totals[:them] += totals_metal[:them] / key_value.to_f
    
    # the total is their total, minus my total
    total = totals[:them] - totals[:my]
    
    estimated = false
    
    if unused.length > 0
      # estimate it
      totals[:them] = totals[:my].abs * 1.22
      total = totals[:them] - totals[:my]
      
      total = total.abs
      estimated = true
    elsif unused_on_their_side.length > 0
      # we don't know
      total = 0
      totals[:them] = totals[:my]
    end
    
    sale_dates = sale_items.map do |sale_item|
      sale_item.sold_at
    end
    
    # this will put the most recent dates towards the front
    sale_dates = sale_dates.sort do |sold_at|
      sold_at.to_i
    end
    
    sold_at = sale_dates[0]
    days_to_sale = sold_at && ((sold_at - steam_trade.traded_at) / 86400).abs.ceil
    
    return {
      :lost => totals[:my],
      :gained => totals[:them],
      :days_to_sale => days_to_sale,
      :sale_items => sale_items,
      :item => steam_trade_item,
      :profit => total,
      :estimated => estimated
    }
  end
end