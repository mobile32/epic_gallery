module Support
  module Matchers
  end
end

require_relative 'matchers/have_error_messages'

RSpec.configure do |config|
  config.include Support::Matchers
end
