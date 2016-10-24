class UsersController < ApplicationController
  def show
    @user = User.find(current_user)
    #@user = User.find_by_id(params[:id])
    @courses = current_user.courses.all

    puts @user.email

  end

end
