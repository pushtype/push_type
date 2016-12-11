require 'test_helper'

module PushType
  module MenuBuilder
    class MenuItemTest < ActiveSupport::TestCase

      let(:item) { MenuBuilder::MenuItem.new :foo }

      it { item.key.must_equal :foo }
      it { item.text.must_equal 'Foo' }
      it { item.link.must_be_nil }
      it { item.active.must_equal false }
      it { item.element.must_equal :li }
      it { item.item_options.must_be_instance_of Hash }
      it { item.link_options.must_be_instance_of Hash }
      it { item.active_class.must_be_nil }

      describe '#submenu' do
        it 'should create a new menu' do
          item.submenu.must_be_instance_of MenuBuilder::Menu
        end
        it 'should use existing submenu if present' do
          menu = item.submenu
          item.submenu.must_equal menu
        end
      end

      describe '#validate!' do
        describe 'without all attributes' do
          it { proc { item.validate! }.must_raise RuntimeError }
        end
        describe 'with all attributes' do
          before { item.link = '/foobar' }
          it { item.validate!.must_equal true }
        end
      end

    end
  end
end
