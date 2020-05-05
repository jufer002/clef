require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Clef
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.after_initialize do
      ActionText::ContentHelper.allowed_attributes.add 'style'
      ActionText::ContentHelper.allowed_attributes.add 'controls'

      ActionText::ContentHelper.allowed_tags.add 'video'
      ActionText::ContentHelper.allowed_tags.add 'source'
    end
  end
end

# Calculates progress of a specific user on a specific course
def calculate_progress(course, user)
  total_lessons = 0.0
  completed_lessons = 0.0
  progress_by_user = Set.new

  # Pick out the lesson ids of all the lessons the user has completed
  Progress.all.each do |progress|
    if progress.user_id == user.id
      progress_by_user.add(progress.lesson_id)
    end
  end

  # Count the amount of total lessons and the amount of lessons completed by the user in this course
  course.sections.each do |section|
    section.lessons.each do |lesson|
      total_lessons += 1
      if progress_by_user.include? lesson.id
        completed_lessons += 1
      end
    end
  end

  if total_lessons == 0
    return 0.0
  else
    return completed_lessons / total_lessons
  end
end