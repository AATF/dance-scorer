class CascadeFKeys < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :scores, :dancers
    remove_foreign_key :scores, :users

    add_foreign_key :scores, :dancers, on_delete: :cascade, on_update: :cascade
    add_foreign_key :scores, :users, on_delete: :cascade, on_update: :cascade

    add_index :scores, :total
    add_index :groups, :name
    add_index :users, :name
  end
end
