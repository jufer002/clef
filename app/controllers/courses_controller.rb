require_relative '../poro/section_chunker'

class CoursesController < ApplicationController
  include SessionsHelper
  include SectionsHelper
  include SectionChunker

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new(user_id: params[:user_id])
  end

  # POST /courses/section/new
  def new_dynamic_section
    # Add a section to a course without redirecting away.
    
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    #section_chunks = get_chunks(params)
    sections = JSON.parse(params['sections'])

    # The course has been created by the signed-in user.
    @course.user_id = current_user.id
    respond_to do |format|
      if @course.save
        # Save the course's subcomponents to the course.
        update_section_chunks(sections)

        format.html { redirect_to @course }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render new_course_path }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    section_chunks = get_chunks(params)

    puts params
    redirect_to @course

    return

    sections = params['sections']
    if sections.nil?
      # Loop through course's existing sections.
      @course.sections.each do |section|

      end
    end
    
    respond_to do |format|
      # Update subcontents
      if update_section_chunks(section_chunks)
        format.html { redirect_to @course }
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

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :user_id, :tag_ids => [])
    end

    def update_section_chunks(section_chunks)
      if section_chunks.empty?
        return false
      end
      
      section_chunks.keys.each do |section_id|
        if add_section_to_course(Section.find(section_id), @course.id)
          lesson_ids = section_chunks[section_id]

          # Add the lessons to the sections.
          lesson_ids.each do |lesson_id|

            lesson_holder = Lesson.where(id: lesson_id)
            # If the lesson doesn't exist, that's fine.
            # Just don't add it to the course.
            if not lesson_holder.exists?
               next
            elsif not add_lesson_to_section(lesson_holder.first, section_id)
              return false
            end
          end
        else
          return false      
        end
      end

      true
    end
end
