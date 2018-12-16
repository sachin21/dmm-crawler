require 'dmm-crawler'
require 'pry'

RSpec.configure do |config|
  config.order = 'random'
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |rspec|
    rspec.syntax = :expect
  end
end
