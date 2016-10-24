class CreateCoursesSemesters < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_semesters do |t|
      t.integer :course_id
      t.integer :semester_id
      t.timestamps
    end
    add_index :courses_semesters, [:course_id, :semester_id]
  end
end
