module PushType
  class MatrixField < ArrayField

    def param
      { name.to_sym => mapping.keys }
    end
    
    def template
      @opts[:template] || :matrix
    end

    def mapping
      @mapping ||= (@opts[:mapping] || []).reduce({}) do |h, col|
        col.is_a?(Hash) ? h.merge(col) : h.update(col => form_helper)
      end
    end

    def to_json(val)
      return if val.blank?
      super.reject { |v| v.blank? or v.values.all?(&:blank?) }
    end

    def from_json(val)
      return if val.blank?
      super.reject { |v| v.blank? or v.values.all?(&:blank?) }.map { |h| struct.new(*h.values) }
    end

    def struct
      @struct ||= Struct.new *mapping.keys
    end

  end
end