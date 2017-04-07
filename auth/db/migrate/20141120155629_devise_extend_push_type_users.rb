class DeviseExtendPushTypeUsers < ActiveRecord::Migration[4.2]
  def change
    ## Database authenticatable
    add_column :push_type_users, :encrypted_password,     :string, null: false, default: ""

    ## Recoverable
    add_column :push_type_users, :reset_password_token,   :string  
    add_column :push_type_users, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :push_type_users, :remember_created_at,    :datetime

    ## Trackable
    add_column :push_type_users, :sign_in_count,          :integer, default: 0, null: false
    add_column :push_type_users, :current_sign_in_at,     :datetime
    add_column :push_type_users, :last_sign_in_at,        :datetime
    add_column :push_type_users, :current_sign_in_ip,     :string
    add_column :push_type_users, :last_sign_in_ip,        :string

    ## Confirmable
    add_column :push_type_users, :confirmation_token,     :string
    add_column :push_type_users, :confirmed_at,           :datetime
    add_column :push_type_users, :confirmation_sent_at,   :datetime
    # add_column :push_type_users, :unconfirmed_email,      :string # Only if using reconfirmable

    ## Lockable
    # add_column :push_type_users, :failed_attempts,        :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    # add_column :push_type_users, :unlock_token,           :string # Only if unlock strategy is :email or :both
    # add_column :push_type_users, :locked_at,              :datetime

    add_index :push_type_users, :email,                unique: true
    add_index :push_type_users, :reset_password_token, unique: true
    # add_index :push_type_users, :confirmation_token,   unique: true
    # add_index :push_type_users, :unlock_token,         unique: true
  end
end
