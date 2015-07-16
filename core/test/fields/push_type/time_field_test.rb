require "test_helper"

module PushType

  describe TimeField do
    let(:field) { PushType::TimeField.new :foo }
    let(:val)   { '15:00' }
    
    it { field.template.must_equal 'date' }
    it { field.form_helper.must_equal :time_field }
    it { field.from_json(val).must_be_instance_of Time }
    it { field.from_json(val).hour.must_equal 15 }
  end

end