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

  def output(account_fields_to_export, account_fields_to_cagr, number_of_accounts)
    array = [@id]
    unless account_fields_to_export.count == 0
      array << @accounts.map {|account| account.output(account_fields_to_export)}
    end
    ((number_of_accounts - @accounts.count)*(account_fields_to_export.count)).times do
      array << nil
    end
    array << self.cagr_period
    array <<  account_fields_to_cagr.map {|field| self.cagr(field)}
    return array.flatten.join(',')
  end

  def latest_account
    @accounts[0]
  end

  def earliest_account
    @accounts[-1]
  end


  def cagr_period
    (Date.parse(latest_account.date).mjd - Date.parse(earliest_account.date).mjd).to_f / 365
  end

  def cagr(field_to_cagr)
    if (latest_account.data[field_to_cagr] && earliest_account.data[field_to_cagr])
      (((latest_account.data[field_to_cagr].to_f)/(earliest_account.data[field_to_cagr].to_f))**(1.to_f/cagr_period)-1)*100
    end
  end


end