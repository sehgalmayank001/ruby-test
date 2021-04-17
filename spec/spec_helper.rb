
require 'simplecov'
require 'rspec/expectations'

RSpec.configure do |config|
  config.color = true
end


SimpleCov.start do
  add_filter '/spec/' 
end

RSpec::Matchers.define :be_sorted_array do
  match do |actual|
    actual == actual.sort
  end
end
