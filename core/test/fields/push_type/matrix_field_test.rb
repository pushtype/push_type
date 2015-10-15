require 'test_helper'

module PushType
  class MatrixFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :matrix do
        field :key, :string
        field :val, :text
      end
    end

    let(:node)  { TestPage.create FactoryGirl.attributes_for(:node, foo: val) }
    let(:val)   { [{ key: 'a', val: 'b' }, { key: 'x', val: 'y' }] }
    let(:field) { node.fields[:foo] }

    it { field.template.must_equal 'matrix' }
    it { field.fields.keys.must_include :key, :val }
    it { field.fields.values.map { |v| v.class }.must_include PushType::StringField, PushType::TextField }
    it { field.json_value.must_equal [{ 'key' => 'a', 'val' => 'b' }, { 'key' => 'x', 'val' => 'y' }] }
    it { field.value.all? { |v| v.class.name == 'PushType::Structure' }.must_equal true }
    it { field.value.first.fields.keys.must_include :key, :val }
    it { field.value[0].key.must_equal 'a' }
    it { field.value[1].val.must_equal 'y' }

  end
end