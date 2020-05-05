class Tag < ApplicationRecord
    has_many :lesson_tags
    has_many :lessons, through: :lesson_tags
    #belongs_to :lessons, required: false

    has_many :course_tags
    has_many :courses, through: :course_tags
    #belongs_to :courses, required: false

    validates :name, presence: true, uniqueness: true

    before_save { name.downcase! }
end
