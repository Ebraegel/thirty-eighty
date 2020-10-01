require 'rspec/retry'
require 'capybara/rspec'
require 'webdrivers'
require 'pry'
require 'yaml'

RSpec.configure do |config|
  config.verbose_retry = true
  config.default_retry_count = 2
  # Only retry when Selenium raises Net::ReadTimeout
  # config.exceptions_to_retry = [Net::ReadTimeout]
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  Capybara::Selenium::Driver.new app, browser: :chrome, options: options
end

Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome

def config
  relative_path = '/../config/config.yml'
  @config ||= YAML.load_file(File.dirname(File.expand_path(__FILE__)) + relative_path)
end
