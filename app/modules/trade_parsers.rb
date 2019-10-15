require './lib/classes/parsers/json_trade_item'

module TradeParsers
  #  _.each(items || [], function(item) {
  #    if (isKey(item)) {
  #        if (!obj.keys) obj.keys = 0;
  #        
  #        obj.keys += 1;
  #    } else if (isMetal(item)) {
  #        if (!obj.metal) obj.metal = 0;
  #        
  #        obj.metal= scrapMetal(metalValue(item) + obj.metal);
  #    } else if (isUnusual(item)) {
  #        if (!obj.unusual) obj.unusual = [];
  #        
  #        obj.unusual.push(getUnusualName(item));
  #    } else {
  #        if (!obj.items) {
  #            obj.items = [];
  #            obj.itemsval = 0;
  #        }
  #        
  #        obj.items.push(item.market_hash_name);
  #        obj.itemsval += (item.value || 0);
  #    }
  #});
  #
  #if (obj.keys || obj.metal) {
  #    obj.currencies = {};
  #}
  #
  #if (obj.keys) {
  #    obj.currencies.keys = obj.keys;
  #}
  #
  #if (obj.metal) {
  #    obj.currencies.metal = obj.metal;
  #}
  #
  #if (obj.itemsval !== undefined) {
  #    obj.itemsval = getKeyValue(obj.itemsval);
  #    
  #    if (obj.itemsval === 0) {
  #        delete obj.itemsval;
  #    }
  #}
  #
  #if (obj.metal) {
  #    if (!obj.keys) obj.keys = 0;
  #    
  #    obj.keys += getKeyValue(obj.metal);
  #    delete obj.metal;
  #}
  def self.get_collection_from_trade_json(items)
    data = {
      :count => items.length,
      :keys => 0,
      :metal => 0,
      :unusuals => [],
      :items => []
    }
    
    items = items.map { |item| JSONTradeItem.new(item) }
    items.each do |item|
      if item.is_key
        data[:keys] += 1
      elsif item.is_metal
        data[:metal] += item.metal_value
      elsif item.is_unusual
        data[:unusuals].push(item)
      else
        data[:items].push(item)
      end
    end
    
    data
  end
  
  def self.trade_json(json)
    
  end
  
  def self.mp_json(json)
    
  end
end