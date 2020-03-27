class CourseContent < ApplicationRecord
  belongs_to :section
  belongs_to :course
end
