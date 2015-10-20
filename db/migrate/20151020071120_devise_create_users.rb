# Devise 用 User
class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_user_table

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end

  private

  def create_user_table
    create_table(:users) do |t|
      add_database_authenticatable_columns t
      add_recoverable_columns t
      add_rememberable_column t
      add_trackable_columns t
      add_confirmable_columns t
      add_lockable_columns t

      t.timestamps null: false
    end
  end

  def add_database_authenticatable_columns(table_definition)
    table_definition.string :email,              null: false, default: ''
    table_definition.string :encrypted_password, null: false, default: ''
  end

  def add_recoverable_columns(table_definition)
    table_definition.string :reset_password_token
    table_definition.datetime :reset_password_sent_at
  end

  def add_rememberable_column(table_definition)
    table_definition.datetime :remember_created_at
  end

  def add_trackable_columns(table_definition)
    table_definition.integer :sign_in_count, default: 0, null: false
    table_definition.datetime :current_sign_in_at
    table_definition.datetime :last_sign_in_at
    table_definition.string :current_sign_in_ip
    table_definition.string :last_sign_in_ip
  end

  def add_confirmable_columns(_table_definition)
    table_definition.string   :confirmation_token
    table_definition.datetime :confirmed_at
    table_definition.datetime :confirmation_sent_at
    table_definition.string   :unconfirmed_email # Only if using reconfirmable
  end

  def add_lockable_columns(_table_definition)
    ## Only if lock strategy is :failed_attempts
    # table_definition.integer  :failed_attempts, default: 0, null: false

    ## Only if unlock strategy is :email or :both
    # table_definition.string   :unlock_token

    # table_definition.datetime :locked_at
  end
end
