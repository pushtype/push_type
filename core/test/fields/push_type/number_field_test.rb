require "test_helper"

module PushType

  describe NumberField do
    let(:field) { PushType::NumberField.new :foo }
    
    it { field.form_helper.must_equal :number_field }
    it { field.to_json(1).must_equal 1 }
    it { field.to_json('1').must_equal 1 }
  end

end