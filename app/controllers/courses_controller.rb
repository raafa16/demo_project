class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    #if current_user.admin?

      @courses = Course.all
      @current_semester = Semester.find_by_active(1)
      @current_semester_courses = @current_semester.courses
      @check_user = current_user.admin
      @semesters = Semester.all

    #end
  end

  def register
    #@selected_courses = params[:courses][:course_ids]||=[]
    #puts @selected_courses

    #course = params[:courses]
    #@selected_courses = course[:course_id]
    @selected_courses = params[:course_ids]
    @registered_courses = Course.find(params[:course_ids])
    @current_semester = Semester.find_by_active(1)
    puts @registered_courses
    #puts @selected_courses
    @selected_courses.each do |c|
      puts '::::::::::::::::::::'
      puts c
       #s = Course.find(c)
      #puts s.inspect

    end
    @selected_courses.each do |course|
      if current_user.courses.exists? (course)

      else
        #current_user.courses << Course.find(course)
        User.update(current_user.id, semester_id: @current_semester.id)
        current_user.courses_users.create(:semester_id => @current_semester.id, :course_id => Course.find(course).id, :user_id => current_user.id)
      end

      #current_user.save!


    end
    redirect_to confirmed_registration_courses_path
  end
  def confirmed_registration
    @current_semester = Semester.find_by_active(1)
    @courses = current_user.courses.where('courses_users.semester_id = ?', @current_semester.id)
  end

  def publish_grade
    if current_user.admin
      #@registered_courses = Course.find(params[:course_ids])
      @current_semester = Semester.find_by_active(1)
      puts @current_semester.name
      @check_user = current_user.admin
      @user_from_current_semesters = User.where(semester_id: @current_semester.id)
      puts @user_from_current_semesters
    end

  end

  def drop
    @course = params[:course_id]
    if current_user.courses.find(@course)
     current_user.courses.delete(@course)
     end
    redirect_to confirmed_registration_courses_path
=begin
    user.courses
    puts current_user.courses
    respond_to do |format|
      format.html { redirect_to confirmed_registration_courses_path, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
=end
  end

  def search
    Rails.logger.info params.inspect
    @user = current_user
    @courses = @user.courses.where('courses_users.semester_id = ?', params[:semester_id])
    render json: @courses
  end

  def confirmed_grade_submission
    @info = params["grade"]

    puts "Suppose to print user ids from hash:"
    @info.each do |k,v|
      v.each do |f,g|
        @user = User.find_by_id(f)
        puts "User ID = #{f} is enrolled in:"
        g.each do |i,j|
          j.each do |k,l|
            puts "Semester id=#{k} and took"
            l.each do |m,n|
              n.each do |p,q|
                puts "Course=#{p} and got"
                q.each do |s,t|
                  puts "Grade: #{t}"
                  @user.courses_users.where('semester_id=? AND course_id=?',k,p ).update_all(:grade => t)
                end
              end
            end
          end
        end
      end
    end

  end


  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @current_semester = Semester.find_by_active(1)

    respond_to do |format|
      if Course.where(:name => @course.name).blank?
        puts 'Course doest not exist'
        if @course.save && @current_semester.courses << @course
          format.html { redirect_to @course, notice: 'Course was successfully created.' }
          format.json { render :show, status: :created, location: @course }
        else
          format.html { render :new }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      else
        puts @course.name
        puts 'Course exists'
        @existing_course = Course.find_by_name(@course.name)
        if @current_semester.courses << @existing_course
          format.html { redirect_to @course, notice: 'Course was successfully created.' }
          format.json { render :show, status: :created, location: @course }
        else
          format.html { render :new }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :credit)
    end
end
