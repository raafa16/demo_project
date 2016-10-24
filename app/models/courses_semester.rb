class CoursesSemester < ApplicationRecord
  belongs_to :course
  belongs_to :semester
end
