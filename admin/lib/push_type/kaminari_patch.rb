module Kaminari
  module Helpers
    class Tag

      def page_url_for(page)
        arguments = @params.merge(@param_name => (page <= 1 ? nil : page), only_path: true).symbolize_keys
        begin
          PushType::Admin::Engine.routes.url_helpers.url_for arguments
        rescue
          @template.main_app.url_for arguments
        end
      end

    end
  end
end
