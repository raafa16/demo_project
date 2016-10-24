class CreateSemesters < ActiveRecord::Migration[5.0]
  def change
    create_table :semesters do |t|
      t.string :name
      t.integer :year
      t.boolean :active

      t.timestamps
    end
  end
end
