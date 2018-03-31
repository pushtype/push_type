require 'test_helper'

module PushType
  class MatrixFieldTest < ActiveSupport::TestCase

    class TestLocation < PushType::Structure
      field :key
    end

    class TestPage < PushType::Node
      field :foo, :matrix, grid: false do
        field :key, :string
        field :val, :text
      end
      field :bar, :matrix, class: 'push_type/matrix_field_test/test_location'
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: val, bar: [{key: '123'}]) }
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

    it { node.bar.first.must_be_instance_of TestLocation }
    it { node.bar.first.class.ancestors.must_include PushType::Structure }
    it { node.fields[:bar].grid?.must_equal true }
    it { node.fields[:foo].grid?.must_equal false }

  end
end