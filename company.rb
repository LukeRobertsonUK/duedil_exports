class Company
  attr_reader :accounts

  def initialize(id)
    @id = id
    @accounts = []
  end

  def standardize_id_length(digits)
    @id.length < digits ? condition = true : condition = false
    while condition
      @id = "0#{@id}"
      condition = false if @id.length > (digits -1)
    end
    return self
  end

  def get_statutory_accounts(number)
    client = Duedil.new
    accounts_list = client.get_page_by_company_id("uk", @id, "accounts").reject{|account| account["type"] != "statutory" }.sort_by{|account| account["date"]}.reverse
    accounts_list[0..(number-1)].each do |list_item|
      account = Account.new(list_item["date"], list_item["type"], list_item["uri"])
      @accounts << account
    end
  end

  def output
    [@id,
      @accounts.map {|account| account.output}
    ].join(',')
  end


end