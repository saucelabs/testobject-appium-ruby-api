module AppiumResource
  def AppiumResource.update_test_report_status( session_id, passed, client )
    client.build_path( session_id )
    client.put_test_outcome(passed)
  end
end