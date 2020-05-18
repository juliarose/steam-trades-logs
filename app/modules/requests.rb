class Requests
  def self.get(url, params = Hash.new)
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params)
    
    Rails.logger.info "GET #{url}"
    Net::HTTP.get_response(uri)
  end
  
  def self.post(url, params = Hash.new)
    uri = URI(url)
    
    Rails.logger.info "POST #{url}"
    Net::HTTP.post_form(uri, params)
  end
end