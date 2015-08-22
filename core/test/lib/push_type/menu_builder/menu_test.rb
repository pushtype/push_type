require 'test_helper'

module PushType
  module MenuBuilder
    class MenuTest < ActiveSupport::TestCase

      let(:menu) { MenuBuilder::Menu.new }

      it { menu.items.must_be_instance_of Array }
      it { menu.element.must_equal :ul }
      it { menu.html_options.must_be_instance_of Hash }
      it { menu.active_class.must_equal 'active' }

      describe '#item' do
        it 'should create a new menu item' do
          menu.item(:foo).must_be_instance_of MenuBuilder::MenuItem
        end
        it 'should use existing menu item if present' do
          item = menu.item(:foo)
          menu.item(:foo).must_equal item
        end
      end

      describe '#insert_at' do
        before do
          menu.item(:foo)
          menu.item(:bar)
          menu.item(:baz)
        end
        it 'should insert at the given index' do
          item = menu.insert_at 1, :bang
          menu.items.find_index(item).must_equal 1
        end
      end

      describe '#insert_before' do
        before do
          menu.item(:foo)
          menu.item(:bar)
          menu.item(:baz)
        end
        it 'should insert before the given key' do
          item = menu.insert_before :baz, :bang
          menu.items.find_index(item).must_equal 2
        end
      end

      describe '#insert_after' do
        before do
          menu.item(:foo)
          menu.item(:bar)
          menu.item(:baz)
        end
        it 'should insert before the given key' do
          item = menu.insert_after :baz, :bang
          menu.items.find_index(item).must_equal 3
        end
      end

    end
  end
end
