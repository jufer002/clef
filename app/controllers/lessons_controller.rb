class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  include SessionsHelper

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
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
    #@lesson.section_ids = params[:lesson][:section_id]
    #puts "**************" + @lesson.section_ids[0]
    
    if @lesson.save
      flash[:success] = 'Lesson created!'
      @section_content = SectionContent.new(:section_id => @lesson.section_ids[0], :lesson_id => @lesson.id)
      if @section_content.save
        flash[:success] = 'Lesson connected to its section!'
        redirect_to @lesson
      else
        flash[:failure] = 'Failed connecting new lesson to section!'
        redirect_to root_path
      end
    else
      render 'new'
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
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
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

    redirect_to Lesson.find(params[:id])
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :body)
    end

    def comment_params
      params.permit(:text)
    end
end
