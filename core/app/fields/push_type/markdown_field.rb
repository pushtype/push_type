require 'redcarpet'

module PushType
  class MarkdownField < PushType::FieldType

    DEFAULT_EXTENSIONS = {
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
      @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
    end

    def renderer
      ( @opts[:renderer] || Redcarpet::Render::HTML ).new render_options
    end

    def render_options
      @opts[:render_options] || {}
    end

    def extensions
      DEFAULT_EXTENSIONS.merge(@opts[:extensions] || {})
    end

    initialized_on_node do |object, field|
      object.presenter_class.class_eval do

        define_method field.name.to_sym do
          fields[field.name.to_sym].markdown.render super()
        end

      end
    end

  end
end