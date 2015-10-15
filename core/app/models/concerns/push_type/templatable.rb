module PushType
  module Templatable
    extend ActiveSupport::Concern

    def template
      self.class.template_path
    end

    def template_args
      [template, self.class.template_opts.except!(:path)]
    end

    module ClassMethods

      def template(name, opts = {})
        @template_name = name.to_s
        @template_opts = opts
      end

      def template_name
        @template_name || self.name.underscore
      end

      def template_path
        File.join template_opts[:path], template_name
      end

      def template_opts
        { path: _ct.base_class.name.demodulize.pluralize.underscore }.merge(@template_opts || {})
      end

    end

  end  
end