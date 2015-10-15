module PushType
  module FieldsHelper

    def render_field(field, f)
      content_tag :div, class: field.kind do
        render "push_type/fields/#{ field.template }", f: f, field: field
      end
    end

    def field_classes(field)
      [field.css_class, 'columns end'].compact.join(' ')
    end

    def merge_repeater_html_options(object_name, field, sub_field)
      opts = {
        name: "#{ object_name }[#{ field.name }][]",
        id:   "#{ object_name }_#{ field.name }_{{ $index }}"
      }
      if [:text_area, :select].include?(sub_field.form_helper)
        opts.merge!(:'ng-model' => "rows[$index]")
      else
        opts.merge!(:'ng-value' => "rows[$index]")
      end
      sub_field.instance_variable_get(:@opts)[:html_options].merge! opts
    end

    def merge_matrix_html_options(object_name, field, sub_field)
      opts = {
        name:   "#{ object_name }[#{ field.name }][][#{ sub_field.name }]",
        id:     "#{ object_name }_#{ field.name }_{{ $index }}_#{ sub_field.name }"
      }
      if [:text_area, :select].include?(sub_field.form_helper)
        opts.merge!(:'ng-model' => "row.#{ sub_field.name }")
      else
        opts.merge!(:'ng-value' => "row.#{ sub_field.name }")
      end
      sub_field.instance_variable_get(:@opts)[:html_options].merge! opts
    end

  end
end
