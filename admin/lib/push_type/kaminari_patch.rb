module Kaminari
  module Helpers
    class Tag

      alias :base_page_url_for :page_url_for

      def page_url_for(page)
        arguments = @params.merge(@param_name => (page <= 1 ? nil : page), only_path: true).symbolize_keys
        begin
          PushType::Admin::Engine.routes.url_helpers.url_for arguments
        rescue
          base_page_url_for(page)
        end
      end

    end
  end
end
