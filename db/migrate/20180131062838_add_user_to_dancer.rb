class AddUserToDancer < ActiveRecord::Migration[5.0]
  def change
    add_column :scores, :user_id, :int

    add_foreign_key :scores, :users
  end
end
