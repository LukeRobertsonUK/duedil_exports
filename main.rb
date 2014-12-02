require 'pry'
require 'httparty'
require 'date'

require_relative 'config'
require_relative 'company'
require_relative 'duedil'
require_relative 'collection'
require_relative 'account'

include FileUtils

# Pull in companies from input file
puts `clear`
puts "Importing IDs..."
collection = Collection.new(Config.input_file, Config.accounts_to_export, Config.fields_to_export)


# get the statutory accounts
collection.pull_from_duedil

# save data to output file
collection.output(output_file)
puts `clear`
puts "******************************************************************"
puts "Companies: #{collection.companies.count}"
puts "Historic Accounts: #{collection.number_of_accounts}"
puts "Fields: #{collection.fields.join(', ')}"
puts "******************************************************************"


