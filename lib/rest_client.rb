require 'httparty'
require 'json'

class RestClient
  def initialize(parameters)
    @api_url = parameters[:api_url]
    @api_key = parameters[:api_key]
  end

  def build_path(session_id)
    @path = "#{@api_url}session/#{session_id}/test/"
  end

  def put_test_outcome(outcome)
    HTTParty.put(@path, basic_auth: basic_authorization, body: { passed: outcome }.to_json, headers: headers, debug_output: $stdout)
  end

  def basic_authorization
    {username: @api_key, password: ""}
  end

  def headers
    { "Content-Type" => "application/json"}
  end
end