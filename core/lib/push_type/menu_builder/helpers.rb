module PushType
  module MenuBuilder
    module Helpers

      def render_menu(key)
        PushType::MenuBuilder::MenuRenderer.new(self).render_menu(key)
      end
      
    end
  end
end