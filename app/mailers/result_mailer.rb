class ResultMailer < ApplicationMailer
  default from: "rahber.test@gmail.com"

  def result_publish(user, info, current_semester, result_hash)
    @user=user
    @info = info
    @current_semester = current_semester
    @result_hash = result_hash
    mail(to: @user.email, subject: "Result for #{@current_semester.name}#{@current_semester.year}")
  end
end
