require 'test/unit'
require 'mocha/test_unit'
require_relative '../test-result-watcher/rest_client.rb'

class TestRestClient < Test::Unit::TestCase

  def setup
    @client = RestClient.new(api_url: "www.testobject.com/", api_key: "TESTOBJECT_API_KEY")
  end

  def test_initialize
    assert_equal("www.testobject.com/", @client.instance_variable_get(:@api_url))
    assert_equal("TESTOBJECT_API_KEY", @client.instance_variable_get(:@api_key))
  end

  def test_build_path
    @client.build_path("my_session_id")
    assert_equal("www.testobject.com/session/my_session_id/test/", @client.instance_variable_get(:@path))
  end

  def test_basic_authorization
    expected_basic_authorization = {username: "TESTOBJECT_API_KEY", password: ""}
    assert_equal(expected_basic_authorization, @client.basic_authorization)
  end

  def test_headers
    expected_header = {"Content-Type" => "application/json"}
    assert_equal(expected_header, @client.headers)
  end
end