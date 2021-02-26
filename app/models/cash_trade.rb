class CashTrade < ApplicationRecord
  monetize :usd, as: :usd_money
  
  belongs_to :steam_trade, optional: true
  belongs_to :processor
  
  # include screenshots associated with trade
  has_many_attached :screenshots
  
  validates :date, :email, :keys, :usd, :processor_id, :txid, :steamid, :presence => true
  
  # there should only be one record matching this pair
  validates_uniqueness_of :txid, scope: :processor_id, case_sensitive: true
  
  # keys will always be an integer
  validates_numericality_of :keys, :only_integer => true
  
  # usd is an integer value in cents
  validates_numericality_of :usd, :only_integer => true
  
  before_save :set_steam_trade, if: :new_record?
  
  private
  
  
  def set_steam_trade
    steam_trade = SteamTrade.where(:steamid_other => self.steamid).order("traded_at DESC").first
    
    raise ActiveRecord::RecordInvalid.new(self) unless steam_trade
    
    self.steam_trade_id = steam_trade.id
  end
end
