module PushType
  module MenuBuilder
    module Dsl

      class MenuItem
        class << self
          def build(item, &block)
            @item = item
            instance_exec(&block)
            @item.validate!
          end

          def text(val=nil, &block)
            @item.text = block_given? ? block : val
          end

          def link(val=nil, &block)
            @item.link = block_given? ? block : val
          end

          def active(val=nil, &block)
            @item.active = block_given? ? block : val
          end

          def element(val)
            @item.element = val
          end

          def item_options(hash)
            @item.item_options.merge!(hash)
          end

          def link_options(hash)
            @item.link_options.merge!(hash)
          end

          def active_class(val)
            @item.active_class = val
          end
        end
      end

    end
  end
end