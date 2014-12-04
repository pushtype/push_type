module PushType
  class FieldType

    attr_reader :name

    def initialize(name, opts)
      @name = name
      @opts = opts
    end

    def kind
      self.class.name.demodulize.underscore.gsub(/_field$/, '')
    end

    def template
      @opts[:template] || 'default'
    end

    def label
      @opts[:label] || name.to_s.humanize
    end

    def html_options
      @opts[:html_options] || {}
    end

    def form_helper
      @opts[:form_helper] || :text_field
    end

    def to_json(val)
      val.to_s
    end

    def from_json(val)
      val.to_s
    end

  end
end
