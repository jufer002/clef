class CourseTag < ApplicationRecord
    belongs_to :course, required: false
    belongs_to :tag, required: false
end
