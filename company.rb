class Company
  attr_accessor :id, :year_zero_date, :year_zero_turnover, :year_minus_one_date, :year_minus_one_turnover, :year_minus_two_date, :year_minus_two_turnover

  def initialize(id)
    @id = id
    @year_zero_date
    @year_zero_turnover
    @year_minus_one_date
    @year_minus_one_turnover
    @year_minus_two_date
    @year_minus_two_turnover
  end

  def make_id_to_eight_digits
    @id.length < 8 ? condition = true : condition = false
    while condition
      @id = "0#{@id}"
      condition = false if @id.length > 7
    end
  end

  def get_accounts_data
    client = Duedil.new
    list_response = client.get_page(@id, "accounts")["data"].reject{|account| account["type"] != "statutory" }.sort_by{|account| account["date"]}.reverse
    if list_response[0]
      @year_zero_date = list_response[0]["date"]
      @year_zero_turnover = client.get(list_response[0]["uri"])["turnover"]
    end
    if list_response[1]
      @year_minus_one_date = list_response[1]["date"]
      @year_minus_one_turnover = client.get(list_response[1]["uri"])["turnover"]
    end
    if list_response[2]
      @year_minus_two_date = list_response[2]["date"]
      @year_minus_two_turnover = client.get(list_response[2]["uri"])["turnover"]
    end

  end

  def company_string
    "#{@id},#{@year_zero_date},#{@year_zero_turnover},#{@year_minus_one_date},#{@year_minus_one_turnover},#{@year_minus_two_date},#{@year_minus_two_turnover}"
  end


end