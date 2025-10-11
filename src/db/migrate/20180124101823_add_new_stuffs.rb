class AddNewStuffs < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    add_column :dancers, :score, :int
    add_column :dancers, :group_id, :int
    add_foreign_key :dancers, :groups
  end
end
