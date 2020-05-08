# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    @lessons = []
    @courses = []
    search_text = params[:search_text].downcase

    unless search_text.blank?
      @lessons << Lesson.where('title LIKE ?', "%#{search_text}%")
      @lessons << Lesson.where('LOWER(title) LIKE ?', "%#{search_text}%")
      # Because ActionText stores rich text in a separate table, we need to join before filtering by
      # the lesson body.
      @lessons << Lesson.joins('INNER JOIN action_text_rich_texts ON action_text_rich_texts.record_id = lessons.id')
                        .where('action_text_rich_texts.body LIKE ?', "%#{search_text}%")
      @lessons = [] if @lessons[0].empty? && @lessons[1].empty?

      @courses << Course.where('title LIKE ?', "%#{search_text}%")
      @courses << Course.where('LOWER(title) LIKE ?', "%#{search_text}%")
      @courses = [] if @courses[0].empty? && @courses[1].empty?
    end
  end
end
