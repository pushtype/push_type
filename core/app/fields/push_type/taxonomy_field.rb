module PushType
  class TaxonomyField < PushType::FieldType

    def param
      multiple? ? { name.to_sym => [] } : super
    end

    def template
      @opts[:template] || 'taxonomy'
    end

    def taxonomy_class
      (@opts[:taxonomy_class].to_s || name.singularize).classify.constantize
    end

    def field_options
      { include_blank: 'Please select...' }.merge(@opts[:field_options] || {})
    end

    def html_options
      super.merge(multiple: multiple?)
    end

    def to_json(val)
      return unless val
      multiple? ? Array(val).reject(&:blank?) : super
    end

    def from_json(val)
      return unless val
      ids = multiple? ? Array(val).reject(&:blank?) : super
      taxonomy_class.find(ids)
    end

    initialized_on_node do |object, field|
      object.class_eval do

        define_method field.id_method_name do
          field_store[field.name]
        end

      end
    end

    def multiple?
      @opts[:multiple] || false
    end

    def taxonomy_tree_to_json
      flatten_tree taxonomy_class.hash_tree
    end

    def id_method_name
      suffix = multiple? ? '_ids' : '_id'
      (name.singularize + suffix).to_sym
    end

    private

    def flatten_tree(hash_tree, d = 0)
      hash_tree.flat_map do |parent, children|
        [
          {
            value:  parent.id,
            text:   parent.title,
            depth:  d
          },
          flatten_tree(children, d+1)
        ]
      end.flatten
    end


  end
end