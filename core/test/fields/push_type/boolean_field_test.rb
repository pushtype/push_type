require 'test_helper'

module PushType
  class BooleanFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :boolean
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: '1') }
    let(:field) { node.fields[:foo] }
    
    it { field.json_primitive.must_equal :boolean }
    it { field.form_helper.must_equal :check_box }
    it { field.json_value.must_equal true }
    it { field.value.must_equal true }

    it { node.foo.must_equal true }

  end
end