class UpdateRequiredFields < ActiveRecord::Migration[5.0]
  def up
    change_column :people, :first_name, :string, :null => false
    change_column :people, :last_name, :string, :null => false

    change_column :events, :event_name, :string, :null => false

    change_column :contests, :title, :string, :null => false

    change_column :judges, :first_name, :string, :null => false
    change_column :judges, :last_name, :string, :null => false
  end

  def down
    change_column :people, :first_name, :string, :null => true
    change_column :people, :last_name, :string, :null => true

    change_column :events, :event_name, :string, :null => true

    change_column :contests, :title, :string, :null => true

    change_column :judges, :first_name, :string, :null => true
    change_column :judges, :last_name, :string, :null => true
  end
end
