module ChartHelper
  
  def format_money_sums(chart)
    chart.clone.map { |k, v| [k, v.to_f / 100] }.to_h
  end
  
  def money_line_chart(chart)
    data = chart.clone
    
    if chart.is_a?(Array)
      data = data.map do |row|
        row[:data] = self.format_money_sums(row[:data])
        row
      end
    else
      data = self.format_money_sums(data)
    end
    
    line_chart data, prefix: "$", thousands: ","
  end
end
