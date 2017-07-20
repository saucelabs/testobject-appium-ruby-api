Gem::Specification.new do |s|
  s.name      = 'test_object_test_result_watcher'
  s.version   = '0.0.0'
  s.date      = '2016-02-04'
  s.summary   = 'Record your Appium results on TestObject'
  s.email     = 'support@testobject.com'
  s.files     = ['lib/appium_resource.rb', 'lib/test_object_test_result_watcher.rb', 'lib/rest_client.rb']
  s.homepage  = 'http://www.testobject.com'
  s.authors   = ['TestObject']
  s.add_runtime_dependency 'httparty',  '~> 0.13'
end
