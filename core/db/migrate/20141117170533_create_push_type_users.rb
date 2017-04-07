class CreatePushTypeUsers < ActiveRecord::Migration[4.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    create_table :push_type_users, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string    :name
      t.string    :email
      t.jsonb     :field_store
      
      t.timestamps null: false
    end
  end
end
