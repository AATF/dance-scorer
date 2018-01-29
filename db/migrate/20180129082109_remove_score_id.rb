class RemoveScoreId < ActiveRecord::Migration[5.0]
  def change
    remove_index :dancers, :score_id
    remove_column :dancers, :score_id
  end
end
