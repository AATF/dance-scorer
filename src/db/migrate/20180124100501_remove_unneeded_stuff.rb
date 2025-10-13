class RemoveUnneededStuff < ActiveRecord::Migration[5.0]
  def change
    drop_table :contests, :if_exists => true

    rename_table :judges, :users

    remove_column :events, :event_name, :string
    remove_column :events, :location, :string
    remove_column :events, :event_director, :string
    remove_column :events, :contest_coordinator, :string
    remove_column :events, :head_judge, :string
    remove_column :events, :event_disclaimer, :string
    remove_column :events, :start_date, :date
    remove_column :events, :end_date, :date
  end
end
