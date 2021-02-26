class InsertCashTradesJob < ApplicationJob
  
  def perform
    trades_file = File.open("/home/colors/Documents/paypal/paypal.json", "r")
    trades_json = JSON.parse(trades_file.read)
    paypal_processor = Processor.find_by_name("PAYPAL")
    paypal_processor_id = paypal_processor.id
    
    trades_json.deep_symbolize_keys[:trades].each do |trade_json|
      unless CashTrade.where(:txid => trade_json[:txid], :processor_id => paypal_processor_id).blank?
        next
      end
      
      trade_json[:date] = Date.strptime(trade_json[:date], "%m/%d/%y")
      
      screenshot_paths = trade_json[:screenshots]
      
      trade_json.delete(:screenshots)
      
      cash_trade = CashTrade.new(trade_json)
      cash_trade.processor_id = paypal_processor_id
      
      # save it
      cash_trade.save
      
      # then attach the screenshots
      screenshot_paths.each do |screenshot_path|
        pathname = Pathname.new(screenshot_path)
        file = File.open(pathname)
        filename = pathname.basename.to_s
        extension = pathname.extname
        mime_type =  Rack::Mime.mime_type(extension)
        
        cash_trade.screenshots.attach(io: file, filename: filename, content_type: mime_type)
      end
    end
  end
end