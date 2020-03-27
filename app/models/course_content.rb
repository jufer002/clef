class CourseContent < ApplicationRecord
  belongs_to :section, required: false
  belongs_to :course, required: false
end
