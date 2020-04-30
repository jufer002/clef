class LessonTag < ApplicationRecord
    belongs_to :lesson#, required: false
    belongs_to :tag, inverse_of: :lesson_tags#, required: false

    validates_presence_of :lesson
    validates_presence_of :tag

    accepts_nested_attributes_for :tag
end
