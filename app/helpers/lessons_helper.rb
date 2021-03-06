module LessonsHelper

  # Get n most recent lessons.
  def recent_lessons(n)
    Lesson.order('id desc').take(n)
  end

  # Get the first 100 characters from a lesson.
  def lesson_excerpt(lesson)
    lesson.body.body.to_s[0, 100] + '...'
  end

  def get_attachment_urls(lesson)
    # Return a list of the urls for a lesson's attachments.
    @lesson.attachments.map do |attachment|
      polymorphic_url(attachment, disposition: "attachment", only_path: true)
    end
  end

  def show_video(blob)
    path = 'C:\Users\Julian\Videos\Captures\romeo.mp4'
    #path = polymorphic_url(blob, disposition: "attachment")

    rails_blob_path(blob)
  end
end
