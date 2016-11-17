module PushType
  module AuthHelper

    def home_path
      main_app.respond_to?(:home_node_path) ? main_app.home_node_path : '/'
    end

  end
end
