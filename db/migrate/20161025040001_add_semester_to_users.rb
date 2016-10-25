class AddSemesterToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :semester, foreign_key: true
  end
end
