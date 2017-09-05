require 'json'
require_relative 'appium_resource.rb'
require_relative 'test_object_rest_client'

class TestObjectTestResultWatcher
  def initialize(desired_capabilities, driver)
    @desired_capabilities = desired_capabilities
    @driver = driver
    @report_results = @desired_capabilities[:caps][:testobject_report_results]
    set_client if @report_results
  end

  def set_client
    rest_api_url = 'https://app.testobject.com/api/rest/v2/appium/'
    testobject_api_key = @desired_capabilities[:caps][:testobject_api_key]
    @client = TestObjectRestClient.new(api_url: rest_api_url, api_key: testobject_api_key)
  end

  def report_results_and_cleanup(passed)
    report_results(passed) if @report_results
    begin
      @driver.quit
    rescue
      begin
        @driver.driver_quit
      rescue
        # ignored
      end
    end
  end

  def report_results(passed)
    AppiumResource.update_test_report_status(@driver.session_id, passed, @client)
  end
end
