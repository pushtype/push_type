require 'redcarpet'

module PushType
  class MarkdownField < PushType::FieldType

    options form_helper:    :text_area,
            renderer:       Redcarpet::Render::HTML,
            render_options: {},
            extensions: {
              autolink:             true,
              fenced_code_blocks:   true,
              no_intra_emphasis:    true,
              space_after_headers:  true,
              strikethrough:        true,
              tables:               true,
              underline:            true
            }

    def compiled_value
      markdown.render value unless value.nil?
    end

    private

    def markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, @opts[:extensions])
    end

    def renderer
      @opts[:renderer].new @opts[:render_options]
    end

    on_instance do |object, field|
      object.presenter_class.class_eval do
        define_method(field.name) { field.compiled_value } unless method_defined?(field.name)
      end
    end

  end
end