class StatsController < ApplicationController
  authorize_resource class: false
  
  # creates charts of data since the given date
  def owner
    owner = params[:owner]
    my_ownerships = BotOwnership.where("steamid = ?", owner)
    owners = BotOwnership.all.map(&:steamid)
    bot_ids = my_ownerships.map(&:bot_id)
    my_bots = Bot.where(:id => bot_ids).map(&:uid)
    
    rejected_bot_ids = BotOwnership.where("bot_id NOT IN (?)", bot_ids).map(&:bot_id).uniq
    other_bots = Bot.where(:id => rejected_bot_ids)
    
    rejected_steamids = other_bots.map(&:uid)
    rejected_steamid_others = (SITE_BOTS + my_bots + owners).uniq
    since = 1.month.ago
    
    rejected_steamids_keys = rejected_steamids.clone
    
    # apples
    # rejected_steamids_keys << "76561198176599590"
    
    @steam_trades = SteamTrade
      .where("traded_at >= ?", since)
      .where("steamid NOT IN (?)", rejected_steamids)
      .where("steamid_other NOT IN (?)", rejected_steamid_others)
    @market_listings = MarketListing.where("date_acted >= ?", since)
    @steam_trade_items = SteamTradeItem
      .joins(:steam_trade)
      .where("steam_trades.traded_at >= ?", since)
      .where("steam_trades.steamid NOT IN (?)", rejected_steamids_keys)
      .where("steam_trades.steamid_other NOT IN (?)", rejected_steamid_others)
      .where({
        :full_name => [
            "Mann Co. Supply Crate Key",
            "Refined MetaL"
        ]
      })
    @steam_trade_keys = SteamTradeItem
      .joins(:steam_trade)
      .where("steam_trades.traded_at >= ?", since)
      .where("steam_trades.steamid NOT IN (?)", rejected_steamids_keys)
      .where("steam_trades.steamid_other NOT IN (?)", rejected_steamid_others)
      .where({
        :full_name => "Mann Co. Supply Crate Key"
      })
    @marketplace_sales = MarketplaceSale.where("date >= ?", since).where("earned_credit >= ?", 0)
    @cash_trades = CashTrade.where("date >= ?", since)
    
    @market_listings_sales = @market_listings.where({ :is_credit => true })
    @market_listings_purchases = @market_listings.where({ :is_credit => false })
    
    @keys_spent = @steam_trade_keys.where({ :is_their_item => false })
    @keys_received = @steam_trade_keys.where({ :is_their_item => true })
    
    @steam_trades_chart = @steam_trades.group_by_day(:traded_at).count
    @market_listings_chart = [
      {
        name: "Sales",
        data: @market_listings_sales.group_by_day(:date_acted).sum("price")
      },
      {
        name: "Purchases",
        data: @market_listings_purchases.group_by_day(:date_acted).sum("price")
      }
    ]
    @steam_trade_keys_chart = [
      {
        name: "Received",
        data: @keys_received.group_by_day("steam_trades.traded_at").count
      },
      {
        name: "Spent",
        data: @keys_spent.group_by_day("steam_trades.traded_at").count
      }
    ]
    @marketplace_sales_chart = @marketplace_sales.group_by_day(:date).sum("earned_credit")
    
    @stats = {
      :keys => {
        :name => "Keys",
        :spent => 0,
        :received => 0
      },
      :metal => {
        :name => "Metal",
        :spent => 0,
        :received => 0
      },
      :scm => {
        :name => "SCM",
        :monetary => true,
        :spent => Money.new(0),
        :received => Money.new(0)
      },
      :usd => {
        :name => "USD",
        :monetary => true,
        :spent => Money.new(0),
        :received => Money.new(0)
      }
    }
    
    if @cash_trades.count > 0
      @stats[:usd][:spent] = @cash_trades.map(&:usd_money).inject(&:+)
    end
    
    @steam_trade_items.each do |steam_trade_item|
      key = steam_trade_item.is_their_item ? :received : :spent
      
      case steam_trade_item.full_name
      when "Mann Co. Supply Crate Key"
        @stats[:keys][key] += 1
      when "Refined Metal"
        # metal values are whole integers
        @stats[:metal][key] += 9
      when "Reclaimed Metal"
        @stats[:metal][key] += 3
      when "Scrap Metal"
        @stats[:metal][key] += 1
      end
    end
    
    # now we convert to 2 decimal refined metal values
    @stats[:metal][:spent] = (@stats[:metal][:spent].to_f / 9).round(2)
    @stats[:metal][:received] = (@stats[:metal][:received].to_f / 9).round(2)
    
    @market_listings.each do |market_listing|
      key = market_listing.is_credit ? :received : :spent
      
      @stats[:scm][key] += market_listing.price_money
    end
    
    @marketplace_sales.each do |marketplace_sale|
      # we use the earned credit column
      @stats[:usd][:received] += marketplace_sale.earned_credit_money
    end
  end
  
end
