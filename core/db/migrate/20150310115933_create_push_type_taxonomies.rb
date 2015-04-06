class CreatePushTypeTaxonomies < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    create_table :push_type_taxonomies, id: :uuid, default: 'uuid_generate_v4()'  do |t|
      t.string    :type
      t.string    :title
      t.string    :slug

      t.uuid      :parent_id
      t.integer   :sort_order

      t.timestamps null: false
    end

    # Also add a tags array to Assets
    add_column :push_type_assets, :tags, :string, array: true
  end
end
