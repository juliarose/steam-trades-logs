class StatsController < ApplicationController
  authorize_resource class: false
  
  # table of totals
  def totals
    rejected_steamids = BOTS
    
    since = 1.month.ago
    steam_trade_items = SteamTradeItem
      .joins(:steam_trade)
      .select("is_their_item, full_name")
      .where("steam_trades.traded_at >= ?", since)
      .where("steam_trades.steamid_other NOT IN (?)", rejected_steamids)
      .all
      .to_a
    market_listings = MarketListing
      .select("price, is_credit")
      .where("date_acted >= ?", since)
      .all
      .to_a
    marketplace_sales = MarketplaceSale
      .select("earned_credit")
      .where("date >= ?", since)
      .all
      .to_a
    
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
    
    steam_trade_items.each do |steam_trade_item|
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
    
    market_listings.each do |market_listing|
      key = market_listing.is_credit ? :received : :spent
      
      @stats[:scm][key] += market_listing.price_money
    end
    
    marketplace_sales.each do |marketplace_sale|
      # we use the earned credit column
      @stats[:usd][:received] += marketplace_sale.earned_credit_money
    end
  end
  
  # creates charts of data since the given date
  def index
    rejected_steamids = BOTS
    since = 1.month.ago
    
    @steam_trades = SteamTrade.non_bot.where("traded_at >= ?", since)
    @market_listings = MarketListing.where("date_acted >= ?", since)
    @steam_trade_keys = SteamTradeItem
      .joins(:steam_trade)
      .where("steam_trades.traded_at >= ?", since)
      .where("steam_trades.steamid_other NOT IN (?)", rejected_steamids)
      .where({
        :full_name => "Mann Co. Supply Crate Key"
      })
    @marketplace_sales = MarketplaceSale.where("date >= ?", since).where("earned_credit >= ?", 0)
    
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
  end
  
end
