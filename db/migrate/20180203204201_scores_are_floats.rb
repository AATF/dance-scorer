class ScoresAreFloats < ActiveRecord::Migration[5.0]
  def change
    change_column :scores, :theme, :float
    change_column :scores, :choreography, :float
    change_column :scores, :technique, :float
    change_column :scores, :presentation, :float
    change_column :scores, :costume, :float
    change_column :scores, :music, :float
    change_column :scores, :violation, :float
    change_column :scores, :total, :float
  end
end
