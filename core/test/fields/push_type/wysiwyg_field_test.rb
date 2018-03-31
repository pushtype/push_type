require 'test_helper'

module PushType
  class WysiwygFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :wysiwyg, toolbar: 'text'
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: val) }
    let(:val)   { 'abc' }
    let(:field) { node.fields[:foo] }
    
    it { field.form_helper.must_equal :text_area }
    it { field.toolbar.must_equal 'text' }
    it { field.html_options[:'froala-toolbar'].must_equal 'text' }
    it { field.json_value.must_equal val }
    it { field.value.must_equal val }

    it { node.foo.must_equal val }
    
  end
end