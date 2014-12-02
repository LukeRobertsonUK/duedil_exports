class Account
  attr_reader :data

  def initialize(date, type, url)
    @date = date
    @type = type
    @url = url
    @data = Duedil.new.get(@url)
  end

  # define which items to export from each set of accounts here
  def output (account_fields_to_export)
    account_fields_to_export.map {|field| @data[field]}.join(',')
  end



end