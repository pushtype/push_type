module PushType
  class TagListQuery

    def initialize(name, type)
      @name = name
      @type = type
    end

    def all(opts = {})
      @opts = { type: @type }.merge(opts)
      connection.select_all(query).rows.flatten
    end

    def node_types
      PushType.subclasses_from_list(:node, @opts[:type]).map { |n| "'#{ n.camelcase }'" }
    end

    private

    def connection
      PushType::Node.connection
    end

    def query
      [
        "SELECT DISTINCT jsonb_array_elements_text(field_data->'#{ @name }') AS _tag",
        "FROM push_type_nodes",
        where_sql,
        "ORDER BY _tag"
      ].compact.join(' ')
    end

    def where_sql
      "WHERE push_type_nodes.type IN (#{ node_types.join(', ') })" unless @opts[:type] == :all || node_types.blank?
    end

  end
end
