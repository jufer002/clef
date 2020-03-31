class SearchController < ApplicationController

  def search
    @lessons = []
    if !params[:search_text].blank?
      @lessons << Lesson.where("title LIKE ?", "%#{params[:search_text]}%")
      @lessons << Lesson.where("body LIKE ?", "%#{params[:search_text]}%")
      
      if @lessons[0].empty? && @lessons[1].empty?
        @lessons = []
      end
    end
  end
end
