require 'push_type/menu_builder/dsl/menu_item'

module PushType
  module MenuBuilder

    class MenuRenderer

      def initialize(view)
        @view = view
      end

      def render_menu(menu_or_key)
        @menu = case menu_or_key
          when Menu   then menu_or_key
          when Symbol then PushType::MenuBuilder.select(menu_or_key)
          else raise('menu_or_key must be a menu of symbol')
        end

        @view.content_tag @menu.element, @menu.html_options do
          @menu.items.inject('') do |str, item|
            str << render_item(item)
          end.html_safe
        end
      end

      def render_item(item)
        text = get_item_value(:text, item)
        link = get_item_value(:link, item)

        css_class = [
          item.item_options[:class],
          ( get_item_value(:active, item) ? item.active_class || @menu.active_class : nil )
        ].compact.join(' ')
        options = item.item_options.merge class: ( css_class if css_class.present? )

        @view.content_tag item.element, @view.link_to(text, link, item.link_options), options
      end

      def get_item_value(key, item)
        val = item.instance_variable_get(:"@#{ key }")
        val.respond_to?(:call) ? @view.instance_exec(&val) : val
      end

    end

  end
end