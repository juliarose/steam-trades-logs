# module for storing certain steamid's

module Steamid
  
  def self.bots
    marketplace_bots = MarketplaceBot.all.map(&:steamid)
    bot_owners = BotOwnership.distinct(:steamid).uniq.map(&:steamid).uniq
    bots = Bot.all.map(&:uid)
    
    (marketplace_bots + bot_owners + bots).uniq
  end
  
  def self.owner_bots
    
  end
end