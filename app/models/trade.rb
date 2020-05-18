require "date"

# unused - but may use later on
class Trade < ApplicationRecord
  include LogItem
  
  validates_presence_of :item_name, :purchased_at
  
  monetize :usd_spent, as: "usd_spent_money", :allow_nil => true
  monetize :scm_spent, as: "scm_spent_money", :allow_nil => true
  monetize :usd_received, as: "usd_received_money", :allow_nil => true
  monetize :scm_received, as: "scm_received_money", :allow_nil => true
    
  has_one :item,
    :foreign_key => :defindex,
    :primary_key => :defindex
  has_one :particle,
    :foreign_key => :value,
    :primary_key => :particle_id
  has_one :quality,
    :foreign_key => :value,
    :primary_key => :quality_id
  has_one :wear,
    :foreign_key => :value,
    :primary_key => :wear_id
  has_one :purchase_market_listing,
    :class_name => :MarketListing,
    :foreign_key => :transaction_id,
    :primary_key => :purchase_market_listing_id
  has_one :sale_market_listing,
    :class_name => :MarketListing,
    :foreign_key => :transaction_id,
    :primary_key => :sale_market_listing_id
  has_one :purchase_steam_trade,
    :class_name => :SteamTrade,
    :foreign_key => :id,
    :primary_key => :purchase_steam_trade_id
  has_one :sale_steam_trade,
    :class_name => :SteamTrade,
    :foreign_key => :id,
    :primary_key => :sale_steam_trade_id
  has_one :sale_marketplace_sale,
    :class_name => :MarketplaceSale,
    :foreign_key => :id,
    :primary_key => :purchase_marketplace_sale_id
  
  scope :missing_purchase, -> { where({
    :purchase_market_listing_id => nil,
    :purchase_steam_trade_id => nil
  }) }
  
  def purchase
    self.purchase_market_listing || self.purchase_steam_trade
  end
  
  def find_purchase(add_reference = true)
    if self.purchased_at.nil?
      # no purchase date
      nil
    elsif !self.scm_spent.nil?
      # find market trade
      # narrow down to listings where the name of the item is the same
      market_listings = MarketListing.where(
        :item_name => self.item_name,
        :is_credit => false
      )
      # find the specific listing which matches most closely with this record
      market_listing = market_listings.find do |record|
        # get the difference of the listing"s date and the date on log
        date_difference = (record.date_acted - self.purchased_at).to_i.abs
        # check that the difference is within a day
        within_one_day_of = date_difference <= 1
        # check that the names match
        matching_names = record.log_name === self.log_name
        
        matching_names && within_one_day_of
      end
      
      if add_reference && market_listing
        # add the reference
        self.purchase_market_listing_id = market_listing.transaction_id
      end
      
      market_listing
    elsif !self.usd_spent.nil?
      # find marketplace purchase
      # current there is no source for this
      nil
    elsif !self.keys_spent.nil? || !self.items_spent.nil?
      # find steam trade where it"s like this
      steam_trade_items = SteamTradeItem.where(
        :item_name => self.item_name,
        :quality_id => self.quality_id,
        :particle_id => self.particle_id,
        # since we purchased this item, the item would be their item in the trade
        :is_their_item => true
      )
      
      # the parent records contain the date when this item was traded
      steam_trades = SteamTrade.where(
        :id => steam_trade_items.map(&:steam_trade_id),
        # compelted offers
        :trade_offer_state => 3
      )
      
      steam_trade = steam_trades.find do |record|
        # get the difference of the listing"s date and the date on log
        date_difference = (record.traded_at.to_date - self.purchased_at).to_i.abs
        # check that the difference is within a day
        within_one_day_of = date_difference <= 1
        
        within_one_day_of
      end
      
      if add_reference && steam_trade
        # add the reference
        self.purchase_steam_trade_id = steam_trade.id
      end
      
      steam_trade
    end
  end
  
  def find_sale
    if self.sold_at.nil?
      # no sale date
      nil
    elsif !self.scm_received.nil?
      
    elsif !self.usd_receied.nil?
      # find market trade
      marketplace_sale_items = MarketplaceSaleItem.where(
        :item_name => self.item_name,
        :quality_id => self.quality_id,
        :particle_id => self.particle_id
      )
      
      # the items belong to sales, and the date for the sale is contained within the parent record
      marketplace_sales = MarketplaceSale.where(:id => marketplace_sale_items.map(&:id))
      marketplace_sale = marketplace_sales.find do |record|
        # get the difference of the listing"s date and the date on log
        date_difference = (marketplace_sale.date - self.purchased_at).to_i.abs
        # check that the difference is within a day
        within_one_day_of = date_difference <= 1
        
        within_one_day_of
      end
      
      if add_reference && market_listing
        # add the reference
        self.purchase_marketplace_sale_id = market_listing.id
      end
      
      marketplace_sale
    elsif !self.keys_received.nil? || !self.items_received.nil?
    end
  end
  
  def days_to_sale
    self.sold_at - self.purchased_at if self.sold_at
  end
  
  def scm_keys_spent
    if self.scm_spent && self.purchased_at
      scm_value = ScmValue.find_by_date(self.purchased_at)
      
      self.scm_spent / scm_value.value if scm_value
    end
  end
  
  def scm_keys_received
    if self.scm_received && self.sold_at
      scm_value = ScmValue.find_by_date(self.sold_at)
      
      self.scm_received / scm_value.value if scm_value
    end
  end
  
  def usd_keys_spent
    if self.usd_spent && self.purchased_at
      usd_value = UsdValue.find_by_date(self.purchased_at)
      
      self.usd_spent / usd_value.value if usd_value
    end
  end
  
  def usd_keys_received
    if self.usd_received && self.sold_at
      usd_value = UsdValue.find_by_date(self.sold_at)
      
      self.usd_received / usd_value.value if usd_value
    end
  end
  
  def purchase_total
    [
      self.keys_spent,
      self.scm_keys_spent,
      self.usd_keys_spent,
      self.items_spent
    ].compact.inject(&:+)
  end
  
  def sale_total
    [
      self.keys_received,
      self.scm_keys_received,
      self.usd_keys_received,
      self.items_received
    ].compact.inject(&:+)
  end
  
  def name
    self.log_name
  end
  
  def profit
    self.sale_total - self.purchase_total if self.sale_total
  end
  
  def profit_percent
    self.sale_total / self.purchase_total if self.sale_total
  end
  
  def self.from_json(json)
    parsed = self.parse_name(json["full_name"])
    # merge parsed object with json
    # and convert all keys from symbols to strings
    data = json.clone.merge(parsed).stringify_keys
    
    # convert date strings to dates
    [
      "purchased_at",
      "sold_at"
    ].each do |k|
      data[k] = Date.parse(data[k]) unless data[k].nil?
    end
    
    # delete non-column keys before creating our record
    data.delete_if do |key, value|
      !self.column_names.include?(key)
    end
    
    Trade.new(data)
  end
  
  def self.batch_json(items)
    items.map do |item|
      self.from_json(item)
    end
  end
end
