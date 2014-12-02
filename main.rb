require 'pry'
require 'httparty'
require 'date'

require_relative 'company'
require_relative 'duedil'
require_relative 'collection'
require_relative 'account'

include FileUtils

# setup
input_file = "input.txt"
sets_of_accounts_to_export = 4
account_fields_to_export = ["date", "turnover", "operating_profits"]
output_file = "output.csv"

# Pull in companies from input file
puts `clear`
puts "Importing IDs..."
collection = Collection.new(input_file, sets_of_accounts_to_export, account_fields_to_export)


# get the last 3 statutory accounts
collection.pull_from_duedil

# save data to output file
collection.output(output_file)
puts `clear`
puts "******************************************************************"
puts "Companies: #{collection.companies.count}"
puts "Historic Accounts: #{collection.number_of_accounts}"
puts "Fields: #{collection.fields.join(', ')}"
puts "******************************************************************"


