class ScoreToDancerMapping < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :dancers, :scores

    add_column :scores, :dancer_id, :int
    add_foreign_key :scores, :dancers
  end
end
