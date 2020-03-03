module LessonsHelper
  
  # Get n most recent lessons.
  def recent_lessons(n)
    Lesson.order('id desc').take(n)
  end
end
