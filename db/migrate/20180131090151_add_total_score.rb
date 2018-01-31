class AddTotalScore < ActiveRecord::Migration[5.0]
  def change
    add_column :scores, :total, :int, null: false
  end
end
