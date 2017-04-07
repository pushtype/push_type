class CreatePushTypeAssets < ActiveRecord::Migration[4.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    create_table :push_type_assets, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string    :file_uid
      t.string    :file_name
      t.integer   :file_size
      t.string    :file_ext
      t.string    :mime_type
      t.string    :description

      t.uuid      :uploader_id

      t.timestamps null: false
      t.datetime  :deleted_at
    end
  end
end
