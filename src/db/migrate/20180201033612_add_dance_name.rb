class AddDanceName < ActiveRecord::Migration[5.0]
  def change
    add_column :dancers, :dance_name, :string, :null => false
  end
end
