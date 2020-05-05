class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
    @courses = Course.all
    @progress = Progress.all
    @courses_with_progress = Set.new
    @progress_in_courses = {}

    # Picks out all the courses that have some progress by the user
    @progress.each do |progress|
      @courses.each do |course|
        course.sections.each do |section|
          section.lessons.each do |lesson|
            if lesson.id == progress.lesson_id
              if !@courses_with_progress.include? course
                @courses_with_progress.add(course)
              end
            end
          end
        end
      end
    end

    # Gets the progress in all courses
    @courses.each do |course|
      @progress_in_courses[course] = calculate_progress(course)
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      # Flash a success message.
      flash[:success] = "Welcome to Clef!"
      # Log in
      log_in @user
      # Redirect home
      redirect_to root_path
    else
      render "new"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def calculate_progress(course)
    total_lessons = 0.0
    completed_lessons = 0.0
    progress_by_user = Set.new
    
    # Pick out the lesson ids of all the lessons the user has completed
    Progress.all.each do |progress|
      if progress.user_id == @user.id
        progress_by_user.add(progress.lesson_id)
      end
    end

    # Count the amount of total lessons and the amount of lessons completed by the user in this course
    course.sections.each do |section|
      section.lessons.each do |lesson|
        total_lessons += 1
        if progress_by_user.include? lesson.id
          completed_lessons += 1
        end
      end
    end

    if total_lessons == 0
      return 0
    else
      return completed_lessons / total_lessons
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation)
  end
end
