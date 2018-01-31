class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table "scores" do |t|
      t.integer "theme"
      t.integer "choreography"
      t.integer "technique"
      t.integer "presentation"
      t.integer "costume"
      t.integer "music"
      t.integer "violation"
    end

    rename_column :dancers, :score, :score_id
    add_foreign_key :dancers, :scores
  end
end
