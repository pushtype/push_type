require 'test_helper'

module PushType
  class StringFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :string
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: val) }
    let(:val)   { 'abc' }
    let(:field) { node.fields[:foo] }
    
    it { field.form_helper.must_equal :text_field }
    it { field.json_value.must_equal val }
    it { field.value.must_equal val }

    it { node.foo.must_equal val }

  end
end