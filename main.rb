require 'pry'
require 'httparty'
require 'date'

require_relative 'company'
require_relative 'duedil'
require_relative 'collection'
require_relative 'account'

include FileUtils

puts `clear`
puts "Importing IDs..."

# Pull in data from input file
f = File.new('input.txt', 'r')
begin
  array_of_ids = []
  f.each do |line|
    array_of_ids << line.chomp
  end
  collection = Collection.new(array_of_ids)
ensure
  f.close
end

# get the last 3 statutory accounts
puts `clear`
counter = 0
puts "Fetching accounts from DueDil: #{counter}"
collection.companies.each do |company|
  company.get_statutory_accounts(3)
  counter += 1
  puts `clear`
  puts "Fetching accounts from DueDil: #{counter}"
end

binding.pry


# save data to output file
output_file = File.new("output.csv", 'w')
begin
  output_file.puts "ID,DATE (0),TURNOVER (0),DATE (-1),TURNOVER (-1),DATE (-2),TURNOVER (-2)"
  collection.companies.each do |company|
    output_file.puts company.output
  end
ensure
  output_file.close
  puts "SUCCESS!"
end

