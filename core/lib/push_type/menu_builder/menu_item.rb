require 'push_type/menu_builder/dsl/menu_item'

module PushType
  module MenuBuilder

    class MenuItem
      attr_reader :key
      attr_accessor :text, :link, :active, :element, :item_options, :link_options, :active_class

      def initialize(key)
        @key          = key.to_sym
        @text         = key.to_s.humanize
        @active       = false
        @element      = :li
        @item_options = {}
        @link_options = {}
      end

      def build(&block)
        PushType::MenuBuilder::Dsl::MenuItem.build(self, &block)
      end

      def submenu(&block)
        @submenu ||= PushType::MenuBuilder::Menu.new
        @submenu.build(&block) if block_given?
        @submenu
      end

      def validate!
        [:text, :link].each do |field|
          raise "Missing '#{ field }' in MenuItem '#{ @key }'" unless send(field).present?
        end
        true
      end
      
    end

  end
end