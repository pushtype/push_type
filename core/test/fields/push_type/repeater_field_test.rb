require 'test_helper'

module PushType
  class RepeaterFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :repeater
      field :bar, :repeater, repeats: :number
      field :baz, :repeater, form_helper: :telephone_field
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: val) }
    let(:val)   { ['abc', 'xyz', '123'] }
    let(:field) { node.fields[:foo] }

    it { field.template.must_equal 'repeater' }
    it { field.json_value.must_equal val }
    it { field.value.must_equal val }
    it { field.rows.must_be_instance_of Array }
    it { field.rows.all? { |r| r.f.must_be_instance_of PushType::StringField } }
    it { field.structure.f.must_be_instance_of PushType::StringField }

    it { node.fields[:bar].structure.f.must_be_instance_of PushType::NumberField }
    it { node.fields[:bar].rows.all? { |r| r.f.must_be_instance_of PushType::NumberField } }
    it { node.fields[:baz].structure.f.must_be_instance_of PushType::StringField }
    it { node.fields[:baz].form_helper.must_equal :telephone_field }
    it { node.fields[:baz].structure.f.form_helper.must_equal :telephone_field }

    it { node.foo.must_equal val }

  end
end