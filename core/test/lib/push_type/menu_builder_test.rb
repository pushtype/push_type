require 'test_helper'

module PushType
  class MenuBuilderTest < ActiveSupport::TestCase

    before  { MenuBuilder.class_variable_set :@@menus, {} }
    after   { MenuBuilder.class_variable_set :@@menus, {} }

    describe '.select' do
      it 'should create a new menu' do
        MenuBuilder.select(:foo).must_be_instance_of MenuBuilder::Menu
      end
      it 'should use existing menu if present' do
        menu = MenuBuilder.select(:bar)
        MenuBuilder.select(:bar).must_equal menu
      end
    end

  end
end
