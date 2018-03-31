require 'test_helper'

module PushType
  class MarkdownFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :markdown
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: md) }
    let(:md)    { '**foo** *bar*' }
    let(:field) { node.fields[:foo] }
    
    it { field.form_helper.must_equal :text_area }
    it { field.json_value.must_equal md }
    it { field.value.must_equal md }
    it { field.compiled_value.strip.must_equal '<p><strong>foo</strong> <em>bar</em></p>' }

    it { node.foo.must_equal md }
    it { node.present!.foo.strip.must_equal '<p><strong>foo</strong> <em>bar</em></p>' }

  end
end