require 'test/unit'
require 'mocha/test_unit'
require_relative '../test-result-watcher/appium_resource.rb'

class TestAppiumResource < Test::Unit::TestCase
  include AppiumResource

  def test_update_test_report_status
    client = Object.new()
    client.expects(:build_path).with("session_id")
    client.expects(:put_test_outcome).with(true)
    update_test_report_status(client: client, session_id: "session_id", passed: true)
  end

end