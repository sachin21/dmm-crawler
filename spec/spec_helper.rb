require 'dmm-crawler'

RSpec.configure do |config|
  config.order = 'random'
  config.expect_with :rspec do |rspec|
    rspec.syntax = :expect
  end
end
