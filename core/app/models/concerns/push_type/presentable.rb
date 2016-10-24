module PushType
  module Presentable
    extend ActiveSupport::Concern

    def presenter_class
      self.class.presenter_class
    end

    def present!(context = nil)
      presenter_class.new(self, context)
    end

    module ClassMethods

      def presenter_class_name
        "#{ self.name.demodulize }Presenter"
      end

      def presenter_class
        unless Object.const_defined?(presenter_class_name)
          Object.const_set presenter_class_name, Class.new(PushType::Presenter)
        end
        Object.const_get presenter_class_name
      end

    end

  end  
end