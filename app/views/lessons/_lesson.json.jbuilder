json.extract! lesson, :id, :title, :user_id, :body, :section_id, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
