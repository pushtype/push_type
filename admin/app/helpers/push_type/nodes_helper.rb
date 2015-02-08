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

  end
end
