module Price
  def is_in_game_currency
    ["keys","metal"].include?(self.currency)
  end
  
  def low_end
    self.value
  end
  
  def high_end
    if self.value_high
      return self.value_high
    end
    
    self.value
  end
  
  def average
    Price.average(self.value, self.value_high)
  end
  
  # displays a string of price range
  def range(with_currency = true)
    values = [
        self.value,
        self.value_high
    ].compact.map do |value|
      value.truncate.prettify
    end
    
    currency = self.currency_symbol if with_currency
    
    [
      values.join("-"),
      currency
    ].compact.join(" ")
  end
  
  def self.average(value, value_high = false)
    if value_high
      return (value.to_f + value_high.to_f) / 2
    end
    
    value
  end
  
  def convert(to = "metal")
    Price.convert(self.average, self.currency, to)
  end
  
  def self.convert(value, from = "keys", to = "metal")
    if from == to
      return value
    end
    
    currency = Currency.find_by_name(from)
    converted_to_value = currency && currency.read_attribute("value_to_#{to}")
    
    if converted_to_value
      return value / converted_to_value 
    end
  end
  
  def currency_symbol
    Price.currency_symbol(self.value, self.currency, self.value_high)
  end
  
  def self.currency_symbol(value, currency, value_high = nil)
    if currency == "metal"
      return "ref"
    elsif currency == "usd"
      return "USD"
    elsif currency == "scm"
      return "SCM"
    elsif currency == "keys" && value_high.nil? && value == 1
      return "key"
    end
    
    currency
  end
  
  def value_with_symbol
    Price.value_with_symbol(self.value, self.currency)
  end
  
  def self.value_with_symbol(value, currency)
    value = value.truncate(2)
    
    if currency == "earbuds" || currency == "keys"
      value = value.round(1)
    end
    
    "#{value.to_s} #{Price.currency_symbol(value, currency)}"
  end
end