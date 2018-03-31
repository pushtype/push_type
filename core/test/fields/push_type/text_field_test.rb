require 'test_helper'

module PushType
  class TextFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :text
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: val) }
    let(:val)   { 'abc' }
    let(:field) { node.fields[:foo] }
    
    it { field.form_helper.must_equal :text_area }
    it { field.json_value.must_equal val }
    it { field.value.must_equal val }

    it { node.foo.must_equal val }

  end
end