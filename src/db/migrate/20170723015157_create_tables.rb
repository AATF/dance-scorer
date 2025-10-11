class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :start_date
      t.date :end_date
      t.string :location
      t.string :event_director
      t.string :contest_coordinator
      t.string :head_judge
      t.text :event_disclaimer

      t.timestamps null: false
    end

    create_table :contests do |t|
      t.string :title
      t.datetime :time
      
      t.belongs_to :event

      t.timestamps null: false
    end

    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :wsdc_id
      t.string :street
      t.string :city
      t.string :state_province
      t.string :postal_code

      t.belongs_to :event

      t.timestamps null: false
    end

    create_table :judges do |t|
      t.string :first_name
      t.string :last_name

      t.belongs_to :event

      t.timestamps null: false
    end
  end
end
