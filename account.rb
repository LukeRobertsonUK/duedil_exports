class Account
  attr_reader :data

  def initialize(date, type, url)
    @date = date
    @type = type
    @url = url
    @data = Duedil.new.get(@url)
  end

  # define which items to export from each set of accounts here
  def output
    [@date,
      @data["turnover"] ].join(',')
  end



end