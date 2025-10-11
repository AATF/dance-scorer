class NoNulls < ActiveRecord::Migration[5.0]
  def change
    users = User.all
    users.each do |user|
      user.username = "blah#{Random.rand(23...29899)}"
      user.save
    end

    change_column_null :users, :username, false
    change_column_null :users, :password_digest, false

    change_column_null :dancers, :score, false
    change_column_null :dancers, :group_id, false
  end
end
