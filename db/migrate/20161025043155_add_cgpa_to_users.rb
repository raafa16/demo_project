class AddCgpaToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cgpa, :decimal, precision: 5, scale: 2
  end
end
