require 'test/unit'
load '../test-result-watcher/test_results.rb'
class TestTestResults < Test::Unit::TestCase
  def test_initialization
    @test = TestResults.new(class_name: "class", method_name: "method", device_id: "real_iphone")
    assert_equal("class", @test.class_name)
    assert_equal("method", @test.method_name)
    assert_equal("real_iphone", @test.device_id)
  end
end