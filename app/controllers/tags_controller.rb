class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
    @tag_relation_l = {}
    @tag_relation_c = {}
    @tags.each do |tag|
      # lessontags = LessonTag.where(tag_id: tag.id)
      # l_array = []
      # lessontags.each do |lesson|
      #   l_array << lesson.lesson
      # end
      # @tag_relation_l[tag] = l_array

      @tag_relation_l[tag] = tag.lessons.to_a

      # coursetags = CourseTag.where(tag_id: tag.id)
      # c_array = []
      # coursetags.each do |course|
      #   c_array << course.course
      # end
      # @tag_relation_c[tag] = c_array

      @tag_relation_c[tag] = tag.courses.to_a
    end

    @new_tag = Tag.new

    @start = params[:start]
    
    20.times do |t| 
      puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" 
    end
    puts @start
    20.times do |t| 
      puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" 
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find_by(id: params[:id])
    lessontags = LessonTag.where(tag_id: params[:id])
    @lessons = []
    lessontags.each do |lesson|
      @lessons << lesson.lesson
    end
    coursetags = CourseTag.where(tag_id: params[:id])
    @courses = []
    coursetags.each do |course|
      @courses << course.course
    end
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to request.referrer, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:category, :name)
    end
end
