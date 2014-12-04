module PushType
  module Templatable
    extend ActiveSupport::Concern

    def template
      self.class.template_name
    end

    def template_args
      [template, self.class.template_opts.except!(:path, :template)]
    end

    module ClassMethods

      def template(name, opts = {})
        @template_opts = opts.merge(template: name)
      end

      def template_name
        File.join template_opts[:path], template_opts[:template]
      end

      def template_opts
        {
          path:     'nodes',
          template: self.name.underscore
        }.merge(@template_opts || {})
      end

    end

  end  
end