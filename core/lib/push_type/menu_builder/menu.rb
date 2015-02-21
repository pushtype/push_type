require 'push_type/menu_builder/dsl/menu'

module PushType
  module MenuBuilder

    class Menu
      attr_reader :items
      attr_accessor :element, :html_options, :active_class

      def initialize
        @items        = []
        @element      = :ul
        @html_options = {}
        @active_class = 'active'
      end

      def build(&block)
        PushType::MenuBuilder::Dsl::Menu.build(self, &block)
      end

      def item(key, &block)
        itm = find_or_create_item(key)
        @items.push itm unless @items.include?(itm)
        itm.build(&block) if block_given?
        itm
      end

      def insert_at(index, key, &block)
        itm = find_or_create_item(key)
        @items.insert index, itm
        itm.build(&block) if block_given?
        itm
      end

      def insert_before(context, key, &block)
        insert_at find_item_index(context), key, &block
      end

      def insert_after(context, key, &block)
        insert_at find_item_index(context, 1), key, &block
      end

      private

      def find_or_create_item(key)
        @items.find { |i| i.key == key.to_sym } || PushType::MenuBuilder::MenuItem.new(key)
      end

      def find_item_index(key, offset = 0)
        idx = @items.find_index { |i| i.key == key.to_sym }
        idx ? idx + offset : @items.length
      end

    end

  end
end