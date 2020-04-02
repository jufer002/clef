class Tag < ApplicationRecord
    has_many :lesson_tags
    belongs_to :lessons, required: false

    has_many :course_tags
    belongs_to :courses, required: false

    validates :name, presence: true, uniqueness: true
end
