module PushType
  class FormBuilder < ActionView::Helpers::FormBuilder

    def custom_field_row(field, &block)
      @template.content_tag :div, class: "row #{ field.kind }" do
        @template.content_tag :div, class: 'columns' do
          @template.render "push_type/fields/#{ field.template }", f: self, field: field
        end
      end
    end

  end
end