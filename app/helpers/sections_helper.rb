module SectionsHelper
  def add_section_to_course(section, course_id)
    course_content = CourseContent.new({ :section_id => section.id, :course_id => course_id })

    course_content.save
  end

  def add_lesson_to_section(lesson, section_id)
    section_content = SectionContent.new({ :lesson_id => lesson.id, :section_id => section_id })

    section_content.save
  end
end
