require "test_helper"

module PushType

  describe MarkdownField do
    let(:field) { PushType::MarkdownField.new :foo }
    
    it { field.form_helper.must_equal :text_area }
    it { field.markdown.must_be_instance_of Redcarpet::Markdown }
    
    describe 'initialized on node' do
      before do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :foo, :markdown
      end
      after { TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new }

      let(:node)  { TestPage.create attrs }
      let(:attrs) { FactoryGirl.attributes_for(:node) }

      describe 'without content' do
        it { node.foo.must_be_nil }
        it { node.present!.foo.must_be_nil }
      end

      describe 'with content' do
        let(:attrs) { FactoryGirl.attributes_for(:node).merge(foo: md) }
        let(:md)    { '**foo** *bar*' }
        it { node.foo.must_equal md }
        it { node.present!.foo.strip.must_equal '<p><strong>foo</strong> <em>bar</em></p>' }
      end
    end
  end

end