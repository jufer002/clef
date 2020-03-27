module SectionsHelper
  def add_section_to_course(section, course_id)
    section_contents = SectionContents.new { section_id: section.id, course_id: course_id }
  end
end
