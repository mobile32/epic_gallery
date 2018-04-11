module Support
  module CapybaraHelpers
  end
end

RSpec.configure do |config|
  config.include Support::CapybaraHelpers

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV['DEBUG'] == 'true'
      driven_by :selenium_chrome
    else
      driven_by :selenium_chrome_headless
    end
  end

  config.before(:each, type: :system, js: true, debug: true) do
    driven_by :selenium_chrome
  end

  # Use Rails System Specs for feature specs
  config.define_derived_metadata(file_path: %r{/spec/features/}) do |metadata|
    metadata[:type] = :system
  end

  # Do not show "booting puma" message in the middle of the specs
  config.before(:all, type: :system) do
    Capybara.server = :puma, { Silent: true }
  end
end