class AddAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, :null => false
  end
end
