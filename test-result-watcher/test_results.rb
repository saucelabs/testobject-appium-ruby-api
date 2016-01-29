class TestResults
  attr_accessor :class_name
  attr_accessor :method_name
  attr_accessor :device_id

  def initialize( test_information )
    @class_name = test_information[:class_name]
    @method_name = test_information[:method_name]
    @device_id = test_information[:device_id]
  end
end