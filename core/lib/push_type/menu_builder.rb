require 'push_type/menu_builder/menu'
require 'push_type/menu_builder/menu_item'
require 'push_type/menu_builder/menu_renderer'
require 'push_type/menu_builder/helpers'

module PushType
  module MenuBuilder
    @@menus = {}

    def self.select(key, &block)
      k = key.to_sym
      @@menus[k] ||= PushType::MenuBuilder::Menu.new
      @@menus[k].build(&block) if block_given?
      @@menus[k]
    end
  end
end