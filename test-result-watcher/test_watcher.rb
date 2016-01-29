require_relative './test_results.rb'
require_relative './appium_resource.rb'
require_relative './rest_client.rb'

module TestWatcher
  Test::Unit::TestCase.startup do
  end

  Test::Unit::TestCase.shutdown do
  end

  Test::Unit::TestCase.setup do
    # Not needed until suite setup
    #@test = TestResults.new(class_name: "", method_name: "", device_id: "")

    set_client
  end

  Test::Unit::TestCase.teardown do
    report_results
  end

  class Test::Unit::TestCase
    def report_results
      unless passed?
        # Not sure why to call these, just following JUnit Test Watcher
        # @driver.page_source
        # @driver.screenshot_as
      end
      update_or_create_suite_report
    end

    def update_or_create_suite_report
      if @suite_report
        update_suite_report
      else
        create_suite_report
      end
    end

    # Ignore this until advanced setup
    def update_suite_report
      unless @suite_report.recognizes_test?(@test)
        raise exception
      end
    end

    def create_suite_report
      AppiumResource.update_test_report_status(session_id: @driver.session_id, passed: passed?, client: @client)
    end

    def set_client
      base_url = "https://app.testobject.com:443/api/rest/appium/v1/"
      @client = RestClient.new(base_url: base_url, api_key: ENV['TESTOBJECT_API_KEY'])
    end
  end
end