require 'appium_lib'
require 'test/unit'
require_relative '../test-result-watcher/test_watcher.rb'

class LoginTest < Test::Unit::TestCase

  def desired_capabilities
      {
          caps:       {
              #Read API key from environment variable.
              #Alternatively, you can just write the string here
              testobject_api_key: ENV['TESTOBJECT_API_KEY'],

              testobject_app_id: '1',
              testobject_device: 'HTC_Nexus_9_real',
              testobject_base_url: 'https://app.testobject.com:443',
              report_results: true
          },
          appium_lib: {
              server_url: 'https://app.testobject.com:443/api/appium/wd/hub',
              wait: 10
          }
      }
  end

  def setup
    @driver = Appium::Driver.new(desired_capabilities).start_driver
    @testwatcher = TestWatcher.new(desired_capabilities, @driver)
  end

  def test_login_with_invalid_credentials
    @driver.find_element(:id, 'de.komoot.android:id/button_mail_login').click
    @driver.find_element(:id, 'de.komoot.android:id/txt_user_name').send_keys("jfjfkdl")
    @driver.find_element(:id, 'de.komoot.android:id/txt_password').send_keys("lakjsdfja")
    @driver.find_element(:id, 'de.komoot.android:id/btn_login').click
    warningMessage = @driver.find_element(:id, "android:id/message")
    assert_equal("Email address invalid.", warningMessage.text)
  end

  def test_always_fails
    assert(false)
  end

  def teardown
    @testwatcher.report_results_and_cleanup(passed?)
  end
end