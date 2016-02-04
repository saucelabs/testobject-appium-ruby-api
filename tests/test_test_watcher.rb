require 'test/unit'
require 'mocha/test_unit'
require 'appium_lib'
load '../test-result-watcher/test_watcher.rb'

class TestTestWatcher < Test::Unit::TestCase
  def setup
    @driver = Object.new
    @driver.stubs(:session_id).returns("my_session_id")
    @driver.stubs(:quit).returns()
    @desired_capabilities = {
        caps:       {
            #Read API key from environment variable.
            #Alternatively, you can just write the string here
            testobject_api_key: ENV['TESTOBJECT_API_KEY'],

            testobject_app_id: '1',
            testobject_device: 'HTC_Nexus_9_real',
            testobject_base_url: 'https://app.testobject.com:443',
            send_results: true
        },
        appium_lib: {
            server_url: 'https://app.testobject.com:443/api/appium/wd/hub',
            wait: 10
        }
    }
    @test_watcher = TestWatcher.new(@desired_capabilities, @driver)
  end

  def test_report_results
    @test_watcher.expects(:update_or_create_suite_report)
    @test_watcher.report_results
  end

  def test_update_or_create_suite_report_with_no_suite_report
    @test_watcher.instance_variable_set(:@suite_report, nil)
    @test_watcher.expects(:create_suite_report)
    @test_watcher.update_or_create_suite_report
  end

  def test_update_or_create_suite_report_with_existing_suite_report
    @test_watcher.instance_variable_set(:@suite_report, 1)
    @test_watcher.expects(:update_suite_report)
    @test_watcher.update_or_create_suite_report
  end
end