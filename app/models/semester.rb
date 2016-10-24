class Semester < ApplicationRecord
  before_create :inactivate_semester


  private
  def inactivate_semester
    Semester.update(active: "false")

  end
end
