class Collection
  attr_reader :companies, :number_of_accounts, :fields

  def initialize(input_file, number_of_accounts, fields)
    @number_of_accounts = number_of_accounts
    @fields = fields
    f = File.new(input_file, 'r')
    begin
      array_of_ids = []
      f.each { |line| array_of_ids << line.chomp }
      @companies = array_of_ids.map { |id| Company.new(id.to_s).standardize_id_length(8) }
    ensure
      f.close
    end
  end

  def pull_from_duedil
    puts `clear`
    counter = 0
    puts "Fetching accounts from DueDil: #{counter}"
    @companies.each do |company|
      company.get_statutory_accounts(@number_of_accounts)
      counter += 1
      puts `clear`
      puts "Fetching accounts from DueDil: #{counter}"
    end
  end

  def row_header
    array = ["id"]
    counter = 0
    while counter < number_of_accounts
      array << @fields.map {|field| "#{field} (#{0 - counter})"}
      counter += 1
    end
    return array.flatten.join(',')
  end

  def output(file)
    output_file = File.new(file, 'w')
    begin
      output_file.puts self.row_header
      @companies.each do |company|
        output_file.puts company.output(@fields)
      end
    ensure
      output_file.close
    end
  end



end