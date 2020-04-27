module SectionChunker

  # Get all the subcomponents of a course from the submitted parameters.
  def get_chunks(params)
    sections = params["section"]

    section_chunks = []

    if sections.nil?
      return section_chunks
    end

    sections.values.each do |section|
      section_title = section["title"]
      section_lessons = section["lesson"]

      section_obj = Section.new(title: section_title)

      # A section chunk contains the section_obj, followed by a list of its lesson_objs.
      section_chunk = [section_obj]

      if section_lessons.nil?
        next
      end

      section_lessons.values.each do |lesson|
        lesson_title = lesson["title"]
        lesson_body = lesson["body"]

        lsn_obj = Lesson.new(title: lesson_title, body: lesson_body, user_id: 1)

        section_chunk << lsn_obj
      end

      section_chunks << section_chunk
    end

    section_chunks
  end

end