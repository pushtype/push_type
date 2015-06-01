class AddFieldStoreDefaultValues < ActiveRecord::Migration
  def change
    change_column :push_type_nodes, :field_store, :jsonb, default: {}, null: false
    change_column :push_type_users, :field_store, :jsonb, default: {}, null: false
  end
end
