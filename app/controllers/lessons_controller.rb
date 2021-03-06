class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  include SessionsHelper
  include SectionsHelper

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson_tags = @lesson.tags
    
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new

    @tags = Tag.all

    @lesson_tag = LessonTag.new

      
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    # The lesson has been composed by the signed-in user.
    @lesson.user_id = current_user.id

    # puts lesson_params
    # puts Tag.find_by(id: lesson_params[:tag_ids]).valid?
    # puts @lesson.valid?
    # puts @lesson.errors.full_messages
    respond_to do |format|
      if @lesson.save
        if params.has_key?('course')
          course_id = params['course']['course_id']
          section_id = params['course']['section_id']

          add_lesson_to_section(@lesson, section_id)
        end
        
        # Get the section, if present and add the lesson to it.
        if params.has_key?('section_id')
          section_id = params['section_id']
          add_lesson_to_section(@lesson, section_id)

          # Redirect to the course which contains the lesson.
          redirect_page = Section.find(section_id).course_contents.first.course
        else
          # Otherwise, just redirect to the lesson.
          redirect_page = @lesson
        end

        if not params.has_key?('no_redirect')
          format.html { redirect_to redirect_page }
        
          format.json { render :show, status: :created, location: @lesson }
        else
          format.js { render "", json: @lesson }
        end
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
        format.js { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    # First remove the lesson from any sections it's in.
    sections_contents = SectionContent.where(lesson_id: @lesson.id).each { |sc| sc.destroy }
    
    @lesson.destroy

    # Don't redirect anywhere if no_redirect is in the params.
    if params.has_key?('no_redirect')
      return
    end

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  # POST /lessons/1
  def post_comment
    @comment = Comment.new(comment_params)

    @comment.lesson_id = params[:id]
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'Comment posted!'
    else
      puts @comment.errors.full_messages
    end

    if params.has_key? "redirect_to"
      redirect_to Course.find(params["redirect_to"])
    else
      redirect_to Lesson.find(params[:id])
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :body, :tag_ids => [])
    end

    def comment_params
      params.permit(:text)
    end

    def sort
      params[:lesson].each_with_index do |id, index|
        Lesson.where('id = ?', id).update_all(position: index+1)
      end
      redirect_back(fallback_location: root_path)
      # render nothing: true
    end
end
