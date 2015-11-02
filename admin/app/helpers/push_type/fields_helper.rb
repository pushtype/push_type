module PushType
  module FieldsHelper

    def render_field(field, f, html_options = {})
      field.instance_variable_get(:@opts)[:html_options].merge! html_options
      content_tag :div, class: field.kind do
        render "push_type/fields/#{ field.template }", f: f, field: field
      end
    end

    def field_classes(field)
      [field.css_class, 'columns end'].compact.join(' ')
    end

  end
end
