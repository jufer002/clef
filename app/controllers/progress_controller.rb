class ProgressController < ApplicationController
  include SessionsHelper

  def complete
    # The progress has been recorded by the signed-in user
      if Progress.new(user_id: current_user.id, lesson_id: params[:lesson_id]).save
        flash[:success] = "Lesson has been saved as completed!"
        redirect_back(fallback_location: root_path)
      end
  
  end

  def undo
    # If we ensure uniqueness in the database, this will always return only one result
    if Progress.where(user_id: current_user.id, lesson_id: params[:lesson_id])[0].destroy
      flash[:success] = "Lesson has been saved as not completed!"
      redirect_back(fallback_location: root_path)
    end
  
  end
end
