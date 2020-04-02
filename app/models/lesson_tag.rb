class LessonTag < ApplicationRecord
    belongs_to :lesson, required: false
    belongs_to :tag, required: false
end
