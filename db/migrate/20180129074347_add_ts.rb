class AddTs < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :scores
  end
end
