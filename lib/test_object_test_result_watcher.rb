require 'json'
require_relative './appium_resource.rb'
require_relative './rest_client.rb'

class TestObjectTestResultWatcher

  def initialize(desired_capabilities, driver)
    @desired_capabilities = desired_capabilities
    @driver = driver
    @report_results = @desired_capabilities[:caps][:testobject_report_results]
    if @report_results
      set_client
    end
  end

  def set_client
    relative_url = "/api/rest/appium/v1/"
    base_url = base_url(@desired_capabilities[:appium_lib][:server_url])
    testobject_api_key = @desired_capabilities[:caps][:testobject_api_key]
    api_url = base_url + relative_url
    @client = RestClient.new(api_url: api_url, api_key: testobject_api_key)
  end

  def base_url(server_url)
    server_url.match(/^https?:\/\/(www.)?\S+.com(:\d+)?/)[0]
  end

  def report_results_and_cleanup(passed)
    if @report_results
      report_results(passed)
    end
    @driver.quit
  end

  def report_results(passed)
    AppiumResource.update_test_report_status(@driver.session_id, passed, @client)
  end
end