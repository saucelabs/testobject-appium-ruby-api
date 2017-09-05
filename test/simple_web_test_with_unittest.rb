require 'appium_lib'
require 'test-unit'
require_relative '../lib/test_object_test_result_watcher'

class SimpleWebTest < Test::Unit::TestCase

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

  def setup
    @driver = Appium::Driver.new(desired_capabilities).start_driver
    @result_watcher = TestObjectTestResultWatcher.new(desired_capabilities, @driver)
  end

  def test_open_google
    @driver.navigate.to('https://www.google.com')
    assert_equal('Google', @driver.title)
  end

  def teardown
    @result_watcher.report_results_and_cleanup(passed?)
  end

end
