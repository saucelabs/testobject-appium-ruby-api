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
            testobject_report_results: true
        },
        appium_lib: {
            server_url: 'https://app.testobject.com:443/api/appium/wd/hub',
            wait: 10
        }
    }
    @test_watcher = TestWatcher.new(@desired_capabilities, @driver)
  end

  def test_base_url
    assert_equal("http://www.testobject.com", @test_watcher.base_url("http://www.testobject.com"))
    assert_equal("http://app.testobject.com:433", @test_watcher.base_url("http://app.testobject.com:433/extra/relative_url/"))
  end

  def test_report_results_and_cleanup_quits_driver
    @driver.expects(:quit)
    @test_watcher.stubs(:report_results).returns()
    @test_watcher.report_results_and_cleanup(true)
  end
end