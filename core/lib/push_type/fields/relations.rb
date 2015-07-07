module PushType
  module Fields
    module Relations
      
      def json_key
        suffix = multiple? ? '_ids' : '_id'
        (name.singularize + suffix).to_sym
      end

      def relation_class
        (@opts[:class] || name).to_s.classify.constantize
      end

      def relation_root
        relation_class
      end

      def relation_tree
        flatten_tree relation_root.hash_tree
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
end