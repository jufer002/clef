class CourseContent < ApplicationRecord
  has_many :sections
  has_many :courses
end
