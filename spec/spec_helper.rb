begin
  require "bundler/setup"
rescue LoadError
  puts "Although not required, bundler is recommended for running the tests."
end
# load the library
require "simplecov"
SimpleCov.start :test_frameworks do
  add_filter "/vendor/bundle/"
end

require "ar2gostruct"
require "rspec"
require "support/models"

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end