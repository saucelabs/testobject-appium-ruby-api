require 'test/unit'
require 'mocha/test_unit'
require 'appium_lib'
require 'test_object_test_result_watcher'

class TestTestObjectTestResultWatcher < Test::Unit::TestCase

  def setup
    @driver = Object.new
    @driver.stubs(:session_id).returns('my_session_id')
    @driver.stubs(:quit).returns
    @desired_capabilities = {
      caps: {
        testobject_api_key: ENV['TESTOBJECT_API_KEY'],
        platformName: 'Android',
        testobject_report_results: true
      },
      appium_lib: {
        server_url: 'https://eu1.appium.testobject.com/wd/hub',
        wait: 10
      }
    }
    @test_watcher = TestObjectTestResultWatcher.new(@desired_capabilities, @driver)
  end

  def test_report_results_and_cleanup_quits_driver
    @driver.expects(:quit)
    @test_watcher.stubs(:report_results).returns
    @test_watcher.report_results_and_cleanup(true)
  end

end
