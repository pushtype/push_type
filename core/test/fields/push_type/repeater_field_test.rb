require 'test_helper'

module PushType
  class RepeaterFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :repeater
      field :bar, :repeater, repeats: :number
      field :baz, :repeater, form_helper: :telephone_field
    end

    let(:node)  { TestPage.create FactoryGirl.attributes_for(:node, foo: val) }
    let(:val)   { ['abc', 'xyz', '123'] }
    let(:field) { node.fields[:foo] }

    it { field.template.must_equal 'repeater' }
    it { field.field.must_be_instance_of PushType::StringField }
    it { field.json_value.must_equal val }
    it { field.value.must_equal val }

    it { node.fields[:bar].field.must_be_instance_of PushType::NumberField }
    it { node.fields[:baz].field.must_be_instance_of PushType::StringField }
    it { node.fields[:baz].form_helper.must_equal :telephone_field }
    it { node.fields[:baz].field.form_helper.must_equal :telephone_field }

    it { node.foo.must_equal val }

  end
end