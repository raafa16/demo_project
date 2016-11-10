module ApplicationHelper
  def check_if_user_registered_this_course(current_user, course_id, semester_id)
  @course_id = course_id
  @semester_id = semester_id
    if current_user.courses_users.exists?(:user_id=> current_user.id, :course_id=> @course_id, :semester_id=>@semester_id) == true
      return true
    else
      return false
    end
  end
end
