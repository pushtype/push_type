module PushType
  module NodesHelper

    def nodes_array(nodes)
      nodes.map { |n| node_hash(n) }
    end

    def node_hash(asset)
      hash = [ :type, :title, :slug, :status, :published_at, :published_to, :new_record?, :published? ].inject({}) do |h, att|
        h.update att => asset.send(att)
      end
    end

    def node_back_link(node)
      if node.trashed?
        push_type_admin.trash_nodes_path
      elsif node.root?
        push_type_admin.nodes_path
      else
        push_type_admin.node_nodes_path(node.parent)
      end
    end

    def sortable?(node)
      !node || node.sortable?
    end

  end
end
