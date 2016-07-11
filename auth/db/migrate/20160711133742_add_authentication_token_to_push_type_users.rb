class AddAuthenticationTokenToPushTypeUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :push_type_users, :authentication_token, :string, limit: 30
    add_index :push_type_users, :authentication_token, unique: true
  end
end
