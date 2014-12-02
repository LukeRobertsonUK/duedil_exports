class Duedil

  def initialize
    @api_key = ENV['DUEDIL_PRO_API_V3_KEY']
    @base_url = "http://duedil.io/v3/uk/companies/"
    @response
  end

  def get_page(company_id, endpoint)
    (HTTParty.get(URI.encode("#{@base_url}#{company_id}/#{endpoint}?api_key=#{@api_key}")))["response"]
  end

  def get(url)
    (HTTParty.get(URI.encode("#{url}?api_key=#{@api_key}")))["response"]
  end

end