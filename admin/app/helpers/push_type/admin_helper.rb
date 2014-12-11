module PushType
  module AdminHelper

    def title(page_title)
      content_for :title, page_title.to_s
    end

    def ficon(kind, label = nil, opts = {})
      opts.merge! class: 'fi-' + kind.to_s.gsub(/_/, '-')
      el = content_tag :i, nil, opts
      [el, label].compact.join(' ').html_safe
    end

    def render_custom_field(field, form_builder)
      classes = [ field.kind, field.column_class, 'columns end' ]
      content_tag :div, class: classes.compact do
        render "push_type/fields/#{ field.template }", f: form_builder, field: field
      end
    end

  end
end
