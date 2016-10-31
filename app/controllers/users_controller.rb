class UsersController < ApplicationController
  def show
    @registered_courses = current_user.courses_users.pluck(:course_id)
    @enrolled_semesters = current_user .courses_users.pluck(:semester_id)
    @total_credit = 0
    @total_credit_earned =0
    @courses = Course.find(@registered_courses)
    @semesters= Semester.find(@enrolled_semesters)
    @cgpa = current_user.cgpa

    end

end
