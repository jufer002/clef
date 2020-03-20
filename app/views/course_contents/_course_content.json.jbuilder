json.extract! course_content, :id, :section_id, :course_id, :created_at, :updated_at
json.url course_content_url(course_content, format: :json)
