module PushType
  class StructureField < PushType::FieldType

    options json_primitive: :object,
            template:       'structure'

    def initialize(*args, &block)
      super
      structure_class.class_eval(&block) if block
    end

    def value
      structure.field_store = json_value unless json_value.blank?
      structure
    end

    def fields
      structure.fields
    end

    private

    def structure_class
      @structure_class ||= PushType::Structure.clone
    end

    def structure
      @structure ||= structure_class.new
    end

    on_class do |klass, field_name, field_class|
      klass.validate do |n|
        unless n.send(field_name).valid?
          n.errors.add field_name, :invalid
        end
      end
    end

  end
end