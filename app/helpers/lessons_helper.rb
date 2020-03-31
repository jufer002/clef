module LessonsHelper
  # Get n most recent lessons.
  def recent_lessons(n)
    Lesson.order('id desc').take(n)
  end

  # Get the first 100 characters from a lesson.
  def lesson_excerpt(lesson)
    lesson.body[0, 100]
  end
end
