class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
      @courses = Course.all
      @current_semester = Semester.find_by_active(1)
      if @courses.present?
        @current_semester_courses = @current_semester.courses
      end
      @check_user = current_user.admin
      @semesters = Semester.all
  end

  def register
    @selected_courses = params[:course_ids]
    @registered_courses = Course.find(params[:course_ids])
    @current_semester = Semester.find_by_active(1)
    @selected_courses.each do |course|
      if current_user.courses.exists? (course)
      else
        User.update(current_user.id, semester_id: @current_semester.id)
        current_user.courses_users.create(:semester_id => @current_semester.id, :course_id => Course.find(course).id, :user_id => current_user.id)
        User.update(current_user.id, published: "false")
      end
    end
    redirect_to confirmed_registration_courses_path
  end

  def confirmed_registration
    @current_semester = Semester.find_by_active(1)
    if @current_semester.present?
      @courses = current_user.courses.where('courses_users.semester_id = ?', @current_semester.id)
    end
  end

  def publish_grade
    if current_user.admin
      @current_semester = Semester.find_by_active(1)
      @check_user = current_user.admin
      if @current_semester.present?
        @user_from_current_semesters = User.where(semester_id: @current_semester.id).paginate(:page => params[:page], :per_page => 5)
      end
    end
  end

  def student_id
    @current_semester = Semester.find_by_active(1)
    @user = User.find(params[:user_id])
    @check_user = current_user.admin
    @courses_taken_by_user = @user.courses.where('courses_users.semester_id = ?', @current_semester.id)
    puts @courses_taken_by_user.inspect
  end


  def drop
    @course = params[:course_id]
    if current_user.courses.find(@course)
      current_user.courses.delete(@course)
    end
    redirect_to confirmed_registration_courses_path
  end

  def search
    Rails.logger.info params.inspect
    @user = current_user
    @courses = @user.courses.where('courses_users.semester_id = ?', params[:semester_id])
    @grades = Hash.new{ |hash, key| hash[key] =[]}

    @courses.each do |course|
      @grade = current_user.courses_users.where('course_id=?', course.id).pluck(:grade)[0]
      @grades[course.id].push course.name
      @grades[course.id].push course.description
      @grades[course.id].push course.credit
      @grades[course.id].push @grade
    end
    render json: @grades
  end

  def confirmed_grade_submission
    @info = params["grade"]
    @current_semester = Semester.find_by_active(1)
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
                  User.where('semester_id=? AND id=?', @current_semester.id, @user.id).update_all(published: "1")
                end
              end
            end
          end
        end
      end
    end
    #updating cgpa after publishing grade
    @registered_courses = @user.courses_users.pluck(:course_id)
    @enrolled_semesters = @user.courses_users.pluck(:semester_id)
    @total_credit = 0
    @total_credit_earned =0
    @courses = Course.find(@registered_courses)
    @semesters= Semester.find(@enrolled_semesters)

    #puts @semesters.name
    #@courses = Course.find(@course_ids)
    #puts @courses
    @courses.each do |course|
      @grade = @user.courses_users.where('course_id=?', course.id).pluck(:grade)[0]
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
        @credit_earned = 0
      end
      @total_credit_earned = @total_credit_earned.to_i + @credit_earned.to_i

    end

    if @user.cgpa.present? && @user.published
      @cgpa = @user.cgpa
      @cgpa = (@cgpa + (@total_credit_earned/@total_credit))/2
      puts @cgpa
      @user.update_attribute(:cgpa, @cgpa)
    else
      @cgpa = @total_credit_earned/@total_credit
      puts @cgpa
      @user.update_attribute(:cgpa, @cgpa)
    end


    #flash[:success] = "Result has been published!"
    @result_hash = {}
    @courses.each do |course|
      @grade = @user.courses_users.where('course_id=?', course.id).pluck(:grade)[0]
      @result_hash[course.name] = @grade
      end
    ResultMailer.result_publish(@user, @info, @current_semester, @result_hash).deliver
    redirect_to publish_grade_courses_url

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
