module CoursesHelper
  # Get n most recent lessons.
  def recent_courses(n)
    Course.order('id desc').take(n)
  end
end
