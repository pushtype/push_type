module PushType
  module Admin
    class Assets

      attr_accessor :javascripts, :stylesheets

      def initialize
        @javascripts = []
        @stylesheets = []
      end

      def register(lib)
        @javascripts << lib
        @stylesheets << lib
      end

    end
  end
end