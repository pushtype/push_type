module PushType
  class MatrixField < PushType::FieldType

    options json_primitive: :array,
            template:       'matrix'

    def initialize(*args, &block)
      super
      structure_class.class_eval(&block) if block
    end

    def value
      return if json_value.blank?
      rows
    end

    def fields
      @fields ||= structure_class.new.fields
    end

    def rows
      Array(json_value).map do |h|
        structure_class.new(field_store: h)
      end
    end

    def structure
      @structure ||= structure_class.new
    end

    private

    def structure_class
      @structure_class ||= PushType::Structure.clone
    end

  end
end