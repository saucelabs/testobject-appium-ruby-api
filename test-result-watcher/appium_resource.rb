module AppiumResource
  def AppiumResource.update_test_report_status( session_id, passed, client )
    client.build_path( session_id )
    client.put_test_outcome(passed)
  end

  # Ignore this until advanced setup
  def update_test_report_name( information )
    session_id = information[:session_id]
    client = client.build_path( session_id )
    client.put_new_name(suite_name: suite_name, test_name: test_name)
  end
end