require "test_helper"

module PushType
  describe Templatable do

    let(:page) { TestPage.new }
    
    describe '.template' do
      describe 'defaults' do
        before do
          # Set class instance variables to nil
          TestPage.instance_variable_set '@template_name', nil
          TestPage.instance_variable_set '@template_opts', nil
        end
        before { page.template.must_equal 'nodes/test_page' }
        before { page.template_args.must_equal ['nodes/test_page', {}] }
      end

      describe 'set template' do
        before { TestPage.template :foo }
        before { page.template.must_equal 'nodes/foo' }
      end

      describe 'set template with args' do
        before { TestPage.template :foo, layout: 'my_layout' }
        before { page.template.must_equal 'nodes/foo' }
        before { page.template_args.must_equal ['nodes/foo', { layout: 'my_layout' }] }
      end
      
    end

  end
end