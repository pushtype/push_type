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

    def field_classes(field)
      [field.column_class, 'columns end'].compact.join(' ')
    end

    def render_field(field, f)
      content_tag :div, class: field.class.name.demodulize.underscore.gsub(/_(field|type)$/, '') do
        render "push_type/fields/#{ field.template }", f: f, field: field
      end
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
