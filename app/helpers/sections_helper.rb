module SectionsHelper
  def add_section_to_course(section, course_id)
    section_contents = CourseContent.new({ :section_id => section.id, :course_id => course_id })

    section_contents.save
  end
end
