require 'push_type/primitives/base'
require 'push_type/primitives/string_type'
require 'push_type/primitives/number_type'
require 'push_type/primitives/array_type'
require 'push_type/primitives/object_type'
require 'push_type/primitives/boolean_type'

module PushType
  class FieldType

    class << self
      attr_reader :def_block, :init_block

      def options(opts = {})
        @options ||= opts
      end

      def on_class(&block)
        @def_block = block
      end

      def on_instance(&block)
        @init_block = block
      end
    end

    attr_reader :name, :model

    def initialize(name, model, opts = {})
      @name     = name
      @model    = model
      @opts     = [defaults, self.class.options, opts].compact.inject(&:deep_merge)
    end

    def kind
      self.class.name.demodulize.underscore.gsub(/_(field|type)$/, '').to_sym
    end

    def primitive
      begin
        "push_type/primitives/#{ json_primitive }_type".camelize.constantize
      rescue NameError
        "#{ json_primitive }_type".camelize.constantize
      end
    end

    def json_value
      model.field_store.try(:[], name.to_s)
    end

    def value
      json_value
    end

    def json_primitive
      @opts[:json_primitive]
    end

    def css_class
      @opts[:css_class]
    end

    def template
      @opts[:template]
    end

    def label
      @opts[:label]
    end

    def form_helper
      @opts[:form_helper]
    end

    def html_options
      @opts[:html_options]
    end

    def field_options
      @opts[:field_options]
    end

    def multiple?
      @opts[:multiple]
    end

    private

    def defaults
      {
        json_primitive: :string,
        template:       'default',
        label:          name.to_s.humanize,
        form_helper:    :text_field,
        html_options:   {},
        field_options:  {},
        multiple:       false
      }
    end

  end
end
