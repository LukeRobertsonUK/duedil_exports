class Duedil

  def initialize
    @api_key = ENV['DUEDIL_PRO_API_V3_KEY']
    @base_url = "http://duedil.io/v3/"
  end

  def get_page_by_company_id(locale, company_id, endpoint)
    response = (HTTParty.get(URI.encode("#{@base_url}#{locale}/companies/#{company_id}/#{endpoint}?api_key=#{@api_key}")))
    response["response"]["data"] if response["response"]
  end

  def get(url)
    response = (HTTParty.get(URI.encode("#{url}?api_key=#{@api_key}")))
    response["response"] if response["response"]
  end

end