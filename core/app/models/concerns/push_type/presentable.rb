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
        Object.const_get presenter_class_name
      rescue NameError
        Object.const_set presenter_class_name, Class.new(PushType::Presenter)
      end

    end

  end  
end