module PushType
  module MenuBuilder
    module Dsl

      class Menu
        class << self
          def build(menu, &block)
            @menu = menu
            instance_exec(&block)
          end

          def item(key, &block)
            @menu.item(key, &block)
          end

          def element(sym)
            @menu.element = sym
          end

          def html_options(hash)
            @menu.html_options.merge!(hash)
          end

          def active_class(val)
            @menu.active_class = val
          end
        end
      end

    end
  end
end