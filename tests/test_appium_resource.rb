require 'test/unit'
require 'mocha/test_unit'
require_relative '../test-result-watcher/appium_resource.rb'

class TestAppiumResource < Test::Unit::TestCase
  def test_update_test_report_status
    client = generate_client
    client.expects(:build_path).with("session_id")
    client.expects(:put_test_outcome).with(true)
    AppiumResource.update_test_report_status("session_id", true, client)
  end

  def generate_client
    client = Object.new()
    client.stubs(:build_path).returns()
    client.stubs(:put_test_outcome).returns()
    client
  end
end