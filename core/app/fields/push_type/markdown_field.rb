require 'redcarpet'

module PushType
  class MarkdownField < PushType::FieldType

    options form_helper: :text_area, renderer: Redcarpet::Render::HTML, render_options: {}, extensions: {
      autolink:             true,
      fenced_code_blocks:   true,
      no_intra_emphasis:    true,
      space_after_headers:  true,
      strikethrough:        true,
      tables:               true,
      underline:            true
    }

    def form_helper
      @opts[:form_helper] || :text_area
    end

    def markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, @opts[:extensions])
    end

    def renderer
      @opts[:renderer].new @opts[:render_options]
    end

    initialized_on_node do |object, field|
      object.presenter_class.class_eval do

        define_method field.name.to_sym do
          fields[field.json_key].markdown.render super()
        end

      end
    end

  end
end