require 'test_helper'

module PushType
  class StructureFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :structure do
        field :key, :string
        field :val, :text
      end
      field :location, :structure
      field :bar, :structure, class: :location
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: val) }
    let(:val)   { { key: 'a', val: 'b' } }
    let(:field) { node.fields[:foo] }

    it { field.template.must_equal 'structure' }
    it { field.fields.keys.must_include :key, :val }
    it { field.fields.values.map { |v| v.class }.must_include PushType::StringField, PushType::TextField }
    it { field.json_value.must_equal({ 'key' => 'a', 'val' => 'b' }) }
    it { field.value.class.name.must_equal 'PushType::Structure' }
    it { field.value.fields.keys.must_include :key, :val }
    it { field.value.key.must_equal 'a' }
    it { field.value.val.must_equal 'b' }

    it { node.foo.class.ancestors.must_include PushType::Structure }
    it { node.location.must_be_instance_of Location }
    it { node.bar.must_be_instance_of Location }
    it { node.location.class.ancestors.must_include PushType::Structure }
    it { node.bar.class.ancestors.must_include PushType::Structure }

  end
end