require 'rspec'
require 'rspec/expectations'
require 'appium_lib'
require_relative 'test_object_test_result_watcher'

def desired_capabilities
  {
    caps: {
      testobject_api_key: 'YOUR_API_KEY',
      platformName: 'Android',
      deviceName: 'LG_Nexus_5X_real',
      testobject_report_results: true
    },
    appium_lib: {
      server_url: 'https://eu1.appium.testobject.com/wd/hub',
      wait: 10
    }
  }
end

RSpec.configure do |config|
  config.before(:each) do
    @driver = Appium::Driver.new(desired_capabilities).start_driver
    @result_watcher = TestObjectTestResultWatcher.new(desired_capabilities, @driver)
  end

  config.after(:each) do |_example|
    @result_watcher.report_results_and_cleanup(_example.exception.nil?)
  end
end

describe 'I' do
  it 'open Google' do
    @driver.navigate.to('https://www.google.com')
    expect(@driver.title).to eq('Google')
  end
end
