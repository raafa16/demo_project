class UsersController < ApplicationController
  def show
    @registered_courses = current_user.courses_users.pluck(:course_id)
    @enrolled_semesters = current_user .courses_users.pluck(:semester_id)
  @total_credit = 0
    @total_credit_earned =0
    @courses = Course.find(@registered_courses)
    @semesters= Semester.find(@enrolled_semesters)
    #puts @semesters.name
    #@courses = Course.find(@course_ids)
    #puts @courses
     @courses.each do |course|
       @grade = current_user.courses_users.where('course_id=?', course.id).pluck(:grade)[0]
       @credit = course.credit

       if @grade === 'A'
         @credit_earned = @credit.to_i*4
         @total_credit = @total_credit + @credit
       elsif @grade === 'B'
         @credit_earned = @credit.to_i*3
         @total_credit = @total_credit + @credit
       elsif @grade === 'C'
         @credit_earned = @credit.to_i*2
         @total_credit = @total_credit + @credit
       elsif @grade === 'D'
         @credit_earned = @credit.to_i*1
         @total_credit = @total_credit + @credit
       elsif @grade === 'F'
         @credit_earned = @credit.to_i*0
         @total_credit = @total_credit + @credit
       elsif @grade === "nil"

       end
       @total_credit_earned = @total_credit_earned.to_i + @credit_earned.to_i

     end

    @cgpa = @total_credit_earned/@total_credit
    puts @cgpa
      current_user.update_attribute(:cgpa, @cgpa)
  end
end
