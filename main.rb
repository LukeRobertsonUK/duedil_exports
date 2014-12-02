require 'pry'
require 'httparty'
require 'date'

require_relative 'company'
require_relative 'duedil'

include FileUtils

puts `clear`
puts "LOADING DATA..."

# Pull in data from input file
f = File.new('input.txt', 'r')
begin
  ids_array = []
  f.each do |line|
    ids_array << line.chomp
  end
  companies_array = ids_array.map { |id| Company.new(id) }
ensure
  f.close
end

# make sure company ids are 8 digits
companies_array.each { |company| company.make_id_to_eight_digits}

# get account data for each company
counter = 0

companies_array.each do |company|
  company.get_accounts_data
  counter += 1
  puts `clear`
  puts counter
end

# save data to output file

output_file = File.new("output.txt", 'w')
begin
  output_file.puts "id,date_year0,turnover_year0,date_year-1,turnover_year-1,date_year-2,turnover_year-2"
  companies_array.each do |company|
    output_file.puts company.company_string
  end
ensure
  output_file.close
end

