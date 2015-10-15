require 'test_helper'

module PushType
  class TemplatableTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
    end

    class TestPageTemplate < PushType::Node
      template :foo
    end

    class TestPageTemplateArgs < PushType::Node
      template :foo, path: 'bar', layout: 'my_layout'
    end

    describe '.template' do
      describe 'defaults' do
        let(:page) { TestPage.new }
        it { page.template.must_equal 'nodes/push_type/templatable_test/test_page' }
        it { page.template_args.must_equal ['nodes/push_type/templatable_test/test_page', {}] }
      end

      describe 'set template' do
        let(:page) { TestPageTemplate.new }
        it { page.template.must_equal 'nodes/foo' }
      end

      describe 'set template with args' do
        let(:page) { TestPageTemplateArgs.new }
        it { page.template.must_equal 'bar/foo' }
        it { page.template_args.must_equal ['bar/foo', { layout: 'my_layout' }] }
      end

    end

  end
end