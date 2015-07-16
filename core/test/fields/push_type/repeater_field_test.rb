require "test_helper"

module PushType

  describe RepeaterField do
    let(:field) { PushType::RepeaterField.new :foo }
    let(:val)   { ['a', 'b', 'c'] }

    describe 'default' do
      it { field.template.must_equal 'repeater' }
      it { field.multiple?.must_equal true }
      it { field.param.must_equal foo: [] }
      it { field.to_json(val).must_be_instance_of Array }
      it { field.to_json(val)[0].must_equal 'a' }
      it { field.from_json(val).must_be_instance_of Array }
      it { field.from_json(val)[0].must_equal 'a' }
    end

  end

end