require 'test_helper'

module PushType
  class StructureFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :structure do
        field :key, :string
        field :val, :text
      end
    end

    let(:node)  { TestPage.create FactoryGirl.attributes_for(:node, foo: val) }
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

  end
end