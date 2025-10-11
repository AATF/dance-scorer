class AddPerformanceOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :dancers, :performance_order, :int, default: 1, null: false
  end
end
