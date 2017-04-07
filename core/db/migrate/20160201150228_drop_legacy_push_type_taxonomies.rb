class DropLegacyPushTypeTaxonomies < ActiveRecord::Migration[4.2]
  def up
    if ActiveRecord::Base.connection.table_exists? :push_type_taxonomies
      drop_table :push_type_taxonomies
    end
    if ActiveRecord::Base.connection.table_exists? :push_type_taxonomy_hierarchies
      drop_table :push_type_taxonomy_hierarchies
    end
    if ActiveRecord::Base.connection.column_exists? :push_type_assets, :tags
      remove_column :push_type_assets, :tags
    end
  end
end
