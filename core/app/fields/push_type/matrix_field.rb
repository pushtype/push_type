module PushType
  class MatrixField < PushType::FieldType

    options json_primitive: :array,
            template:       'matrix',
            grid:           true

    def initialize(*args, &block)
      super
      structure_class.class_eval(&block) if block
    end

    def value
      return if json_value.blank?
      rows.reject(&:blank?)
    end

    def fields
      @fields ||= structure_class.new.fields
    end

    def grid?
      !!@opts[:grid]
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
      @structure_class ||= begin
        raise NameError unless @opts[:class]
        @opts[:class].to_s.classify.constantize
      rescue NameError
        Class.new PushType::Structure do
          define_singleton_method(:name) { "PushType::Structure" }
        end
      end
    end

  end
end