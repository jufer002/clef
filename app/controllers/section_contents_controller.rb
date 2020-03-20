class SectionContentsController < ApplicationController
  before_action :set_section_content, only: [:show, :edit, :update, :destroy]

  # GET /section_contents
  # GET /section_contents.json
  def index
    @section_contents = SectionContent.all
  end

  # GET /section_contents/1
  # GET /section_contents/1.json
  def show
  end

  # GET /section_contents/new
  def new
    @section_content = SectionContent.new
  end

  # GET /section_contents/1/edit
  def edit
  end

  # POST /section_contents
  # POST /section_contents.json
  def create
    @section_content = SectionContent.new(section_content_params)

    respond_to do |format|
      if @section_content.save
        format.html { redirect_to @section_content, notice: 'Section content was successfully created.' }
        format.json { render :show, status: :created, location: @section_content }
      else
        format.html { render :new }
        format.json { render json: @section_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /section_contents/1
  # PATCH/PUT /section_contents/1.json
  def update
    respond_to do |format|
      if @section_content.update(section_content_params)
        format.html { redirect_to @section_content, notice: 'Section content was successfully updated.' }
        format.json { render :show, status: :ok, location: @section_content }
      else
        format.html { render :edit }
        format.json { render json: @section_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_contents/1
  # DELETE /section_contents/1.json
  def destroy
    @section_content.destroy
    respond_to do |format|
      format.html { redirect_to section_contents_url, notice: 'Section content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_content
      @section_content = SectionContent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def section_content_params
      params.require(:section_content).permit(:section_id, :lesson_id)
    end
end
