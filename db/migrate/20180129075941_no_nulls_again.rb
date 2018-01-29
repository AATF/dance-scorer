class NoNullsAgain < ActiveRecord::Migration[5.0]
  def change
    change_column_null :scores, :theme, false
    change_column_null :scores, :choreography, false
    change_column_null :scores, :technique, false
    change_column_null :scores, :presentation, false
    change_column_null :scores, :costume, false
    change_column_null :scores, :music, false
    change_column_null :scores, :violation, false

    change_column_null :groups, :name, false
  end
end
