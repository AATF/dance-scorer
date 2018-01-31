class MoreNotNulls < ActiveRecord::Migration[5.0]
  def change
    change_column_null :scores, :dancer_id, false
    change_column_null :scores, :user_id, false
  end
end
