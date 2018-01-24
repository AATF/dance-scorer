class RemoveMoreStuff < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :event_id, :int

    rename_table :people, :dancers

    remove_column :dancers, :email, :string
    remove_column :dancers, :street, :string
    remove_column :dancers, :city, :string
    remove_column :dancers, :state_province, :string
    remove_column :dancers, :postal_code, :string
    remove_column :dancers, :wsdc_id, :int
    remove_column :dancers, :event_id, :int
  end
end
