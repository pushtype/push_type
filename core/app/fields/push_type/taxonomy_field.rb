module PushType
  class TaxonomyField < SelectField

    def template
      @opts[:template] || 'taxonomy'
    end

    def choices
      []
    end

    def from_json(val)
      return unless val
      ids = multiple? ? Array(val).reject(&:blank?) : super
      taxonomy_class.find(ids)
    end

    initialized_on_node do |object, field|
      object.class_eval do

        define_method field.relation_id_method do
          field_store[field.name]
        end

      end
    end

    def singular_name
      multiple? ? name.singularize : name
    end

    def taxonomy_class
      (@opts[:taxonomy_class] || singular_name).to_s.classify.constantize
    end

    def taxonomy_tree_to_json
      flatten_tree taxonomy_class.hash_tree
    end

    def relation_id_method
      suffix = multiple? ? '_ids' : '_id'
      (singular_name + suffix).to_sym
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