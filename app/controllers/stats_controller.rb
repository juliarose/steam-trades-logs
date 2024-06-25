class StatsController < ApplicationController
  authorize_resource class: false
  
  # creates charts of data since the given date
  def owner
    owner = params[:owner]
    my_ownerships = BotOwnership.where("steamid = ?", owner)
    owners = BotOwnership.all.map(&:steamid)
    bot_ids = my_ownerships.map(&:bot_id)
    my_bots = Bot.where(:id => bot_ids).map(&:steamid)
    
    rejected_bot_ids = BotOwnership.where("bot_id NOT IN (?)", bot_ids).map(&:bot_id).uniq
    other_bots = Bot.where(:id => rejected_bot_ids)
    
    rejected_steamids = other_bots.map(&:steamid)
    marketplace_bots = MarketplaceBot.all.map(&:steamid)
    rejected_steamid_others = (DONATION_BOTS + marketplace_bots + my_bots + owners).uniq
    since = 1.month.ago
    
    @steam_trades = SteamTrade
      .where("traded_at >= ?", since)
      .where("steamid NOT IN (?)", rejected_steamids)
      .where("steamid_other NOT IN (?)", rejected_steamid_others)
    @market_listings = MarketListing.where("date_acted >= ?", since)
    @steam_trade_items = SteamTradeItem
      .joins(:steam_trade)
      .where("steam_trades.traded_at >= ?", since)
      .where("steam_trades.steamid NOT IN (?)", rejected_steamids)
      .where("steam_trades.steamid_other NOT IN (?)", rejected_steamid_others)
    @marketplace_sales = MarketplaceSale.where("date >= ?", since)
    @cash_trades = CashTrade.where("date >= ?", since)
    
    @market_listings_sales = @market_listings.where({ :is_credit => true })
    @market_listings_purchases = @market_listings.where({ :is_credit => false })
    
    @steam_trades_chart = @steam_trades.group_by_day(:traded_at).count
    
    # these are all SQL-safe
    currency_names = [
      "Mann Co. Supply Crate Key",
      "Refined Metal",
      "Reclaimed Metal",
      "Scrap Metal"
    ]
    item_names_sql_str = currency_names.map { |a| SteamTradeItem.connection.quote(a) }.join(", ")
    since_date_sql_str = since.utc.to_s(:db)
    rejected_steamids_sql_str = rejected_steamids.map { |a| SteamTradeItem.connection.quote(a) }.join(", ")
    rejected_steamid_others_sql_str = rejected_steamid_others.map { |a| SteamTradeItem.connection.quote(a) }.join(", ")
    
    # since this is such a complex query and it's difficult to build in rails
    sql = %{
      SELECT
        COUNT(*) AS count,
        `steam_trade_items`.`is_their_item` AS is_their_item,
        `steam_trade_items`.`item_name` AS item_name,
        CONVERT_TZ(DATE_FORMAT(CONVERT_TZ(`steam_trades`.`traded_at`, '+00:00', 'Etc/UTC'), '%Y-%m-%d 00:00:00'), 'Etc/UTC', '+00:00') AS traded_at
      FROM `steam_trade_items`
      INNER JOIN `steam_trades` ON `steam_trades`.`id` = `steam_trade_items`.`steam_trade_id`
      WHERE
        `steam_trade_items`.`item_name` IN (#{item_names_sql_str}) AND
        `steam_trades`.`traded_at` >= '#{since_date_sql_str}' AND
        `steam_trades`.`steamid` NOT IN (#{rejected_steamids_sql_str}) AND
        `steam_trades`.`steamid_other` NOT IN (#{rejected_steamid_others_sql_str})
      GROUP BY 
        `steam_trade_items`.`is_their_item`,
        `steam_trade_items`.`item_name`,
        CONVERT_TZ(DATE_FORMAT(CONVERT_TZ(`steam_trades`.`traded_at`, '+00:00', 'Etc/UTC'), '%Y-%m-%d 00:00:00'), 'Etc/UTC', '+00:00')
    }.gsub(/\s+/, " ").strip
    steam_trade_items_groups_query = ActiveRecord::Base.connection.execute(sql)
    
    date_range = Hash[(since.to_date..Time.now.to_date).map { |date| [date, 0] }]
    
    @steam_trade_items_groups = {
      0 => {},
      1 => {}
    }
    
    currency_names.each do |currency_name|
      [
        0,
        1
      ].each do |is_their_item|
        @steam_trade_items_groups[is_their_item][currency_name] = date_range.clone
      end
    end
    
    steam_trade_items_groups_query.to_a.each do |row|
      count, is_their_item, item_name, traded_at = row
      
      traded_at = traded_at.to_date
      
      @steam_trade_items_groups[is_their_item][item_name][traded_at] = count
    end
    
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
    
    logger.info @market_listings_chart[0][:data]
    logger.info @steam_trade_items_groups[1]["Mann Co. Supply Crate Key"]
    
    @steam_trade_keys_chart = [
      {
        name: "Received",
        data: @steam_trade_items_groups[1]["Mann Co. Supply Crate Key"]
      },
      {
        name: "Spent",
        data: @steam_trade_items_groups[0]["Mann Co. Supply Crate Key"]
      }
    ]
    @marketplace_sales_chart = @marketplace_sales.group_by_day(:date).sum("earned_credit")
    
    
    metal_spent = 0
    metal_received = 0
    
    [
      "Refined Metal",
      "Reclaimed Metal",
      "Scrap Metal"
    ].each do |metal_type|
      values = {
        "Refined Metal" => 1,
        "Reclaimed Metal" => 3,
        "Scrap Metal" => 9
      }
      value = values[metal_type]
      spent = @steam_trade_items_groups[0][metal_type].values.inject(&:+)
      received = @steam_trade_items_groups[1][metal_type].values.inject(&:+)
      
      metal_spent += (spent / value).to_i
      metal_received += (received / value).to_i
    end
    
    @stats = {
      :keys => {
        :name => "Keys",
        :spent => @steam_trade_items_groups[0]["Mann Co. Supply Crate Key"].values.inject(&:+),
        :received =>@steam_trade_items_groups[1]["Mann Co. Supply Crate Key"].values.inject(&:+)
      },
      :metal => {
        :name => "Metal",
        :spent => metal_spent,
        :received => metal_received
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
    
    # now we convert to 2 decimal refined metal values
    # @stats[:metal][:spent] = (@stats[:metal][:spent].to_f / 9).round(2)
    # @stats[:metal][:received] = (@stats[:metal][:received].to_f / 9).round(2)
    
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
