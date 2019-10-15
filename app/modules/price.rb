module Price
  #def value
  #  val = read_attribute(:value)
  #  return (val && self.is_in_game_currency) ? Price.precision(val) : val
  #end
  
  #def value_high
  #  val = read_attribute(:value_high)
  #  return (val && self.is_in_game_currency) ? Price.precision(val) : val
  #end
  
  def is_in_game_currency
    ['keys','metal'].include?(self.currency)
  end
  
  def low_end
    return self.value
  end
  
  def high_end
    if self.value_high
      return self.value_high
    else
      return self.value
    end
  end
  
  def average
    return Price.average(self.value, self.value_high)
  end
  
  def self.scrap(value, currency)
    return (Price.convert(value, currency, 'metal') * 9.0).floor
  end
  
  def range(with_currency = true)
    v = [ self.value,
          self.value_high ].compact.map { |a| a.truncate.prettify }.join('-')
    c = self.currency_symbol if with_currency
    
    return [v,c].compact.join(' ')
  end
  
  def self.precision(value, places = 4)
    remainder = (value % 1).round(2)
    precise_number = (1..18).map { |i| (i / 18.0) }.find { |a| remainder == a.truncate }
    value = value.floor + precise_number if precise_number
   
    return value.prettify
  end
  
  def self.average(value, value_high = false)
    unless value_high
      return value
    else
      return (value.to_f + value_high.to_f) / 2
    end
  end
  
  def self.nearest(value, currency = 'metal', pretty = false, larger_unit = false)
    remainder = value % 1
    value = (value - remainder).round.to_f
    
    if value.round(2) % 1 == 0
      return value.prettify
    else
      if currency == 'metal'
        arr_step = 0.11
        
        if pretty
          if larger_unit || value > 6
            arr_step = 1
          elsif value > 2
            arr_step = 0.33
          end
        end
        
        compare = (remainder) + (arr_step * 0.5)
        return value + Price.nearest_array(arr_step).select { |a| a < compare }.max
      else
        return value + remainder.round(2)
      end
    end
  end
  
  def self.nearest_array(step = 0.11)
    arr = [0]
    
    while arr.last < 1
      arr.push(step * arr.length)
    end
    
    arr[arr.length - 1] = 1
    return arr
  end
  
  def convert(to = 'scm', except_when = 'usd')
    if self.currency == except_when
      return self.average
    else
      return Price.convert(self.average, self.currency, to)
    end
  end
  
  def self.convert(value, from = 'keys', to = 'metal')
    if from == to || value.nil?
      return value
    else
      currency = Currency.find_by_name(from)
      converted_to_value = currency && currency.read_attribute("value_to_#{to}")
      
      if converted_to_value
        return value / converted_to_value 
      else
        return nil
      end
    end
  end
  
  def self.smart_conversion(value, from = 'metal')
    return nil unless value
    converted = from
    
    unless value <= 1 && from == 'metal'
      currency = Currency.find_by_name(from)
      
      if currency
        value_in_keys = value / currency.value_to_keys
        value_in_metal = value / currency.value_to_metal
        
        if value_in_keys >= 1
          value = value_in_keys
          converted = 'keys'
        else
          value = value_in_metal
          converted = 'metal'
        end
      end
    end
    
    return GenericPrice.new({ :value => value, :currency => converted })
  end
  
  def pretty_price
    return Price.pretty_price(self.average, self.currency)
  end
  
  def self.pretty_price(value, currency = 'metal', separator = ', ')
    return Price.split_units(value, currency, separator, true)
  end
  
  def self.split_units(value, currency = 'metal', separator = ', ', pretty = false)
    return nil unless ['keys', 'metal'].include?(currency)
    
    base_currency = Currency.find_by_name(currency)
    
    if base_currency && base_currency.is_in_game_currency
      value_in_keys = value / base_currency.value_to_keys
      remainder = value_in_keys % 1
      value_in_keys = (value_in_keys - remainder).round.to_f
      value_in_metal = Price.nearest(remainder / base_currency.value_to_metal, 'metal', pretty, value_in_keys > 0)
      values = [ { :currency => 'keys', :value => value_in_keys }, { :currency => 'metal', :value => value_in_metal } ].reject { |a| a[:value] == 0 }
      results = Array.new
      
      values.each do |a|
        value = a[:value].round(2).prettify
        symbol = currency_symbol(value, a[:currency])
        results.push("#{value} #{symbol}") if value > 0
      end
      
      return results.join(separator)
    else
      return nil
    end
  end
  
  def currency_symbol
    return Price.currency_symbol(self.value, self.currency, self.value_high)
  end
  
  def self.currency_symbol(value, currency, value_high = nil)
    if currency == 'metal'
      return 'ref'
    elsif currency == 'usd'
      return 'USD'
    elsif currency == 'scm'
      return 'SCM'
    elsif currency == 'keys' && value_high.nil? && value == 1
      return 'key'
    else
      return currency
    end
  end
  
  def value_with_symbol
    return Price.value_with_symbol(self.value, self.currency)
  end
  
  def self.value_with_symbol(value, currency)
    value = value.truncate(2)
    
    if currency == 'earbuds' || currency == 'keys'
      value = value.round(1)
    end
    
    return "#{value.to_s} #{Price.currency_symbol(value, currency)}"
  end
end