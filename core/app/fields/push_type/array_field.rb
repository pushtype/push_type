module PushType
  class ArrayField < PushType::FieldType
    def param
      { name.to_sym => [] }
    end

    def to_json(val)
      return unless val
      Array(val)
    end

    def from_json(val)
      Array(val)
    end
  end
end