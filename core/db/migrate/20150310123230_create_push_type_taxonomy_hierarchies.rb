class CreatePushTypeTaxonomyHierarchies < ActiveRecord::Migration
  def change
    create_table :push_type_taxonomy_hierarchies, id: false do |t|
      t.uuid      :ancestor_id,     null: false
      t.uuid      :descendant_id,   null: false
      t.integer   :generations,     null: false
    end

    add_index :push_type_taxonomy_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "taxonomy_anc_desc_idx"

    add_index :push_type_taxonomy_hierarchies, [:descendant_id],
      name: "taxonomy_desc_idx"
  end
end
