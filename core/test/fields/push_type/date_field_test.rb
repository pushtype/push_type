require 'test_helper'

module PushType
  class DateFieldTest < ActiveSupport::TestCase

    let(:field) { PushType::DateField.new :foo }
    let(:val)   { Date.today.to_s }
    
    it { field.template.must_equal 'date' }
    it { field.form_helper.must_equal :date_field }
    it { field.from_json(val).must_be_instance_of Date }

  end
end