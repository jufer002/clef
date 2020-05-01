class Course < ApplicationRecord
  # No unbounded lessons; only lessons in sections are allowed
  belongs_to :user
  has_many :course_contents
  has_many :sections, through: :course_contents

  #course tag relations
  has_many :course_tags, inverse_of: :course
  has_many :tags, through: :course_tags
  accepts_nested_attributes_for :course_tags

  # Validates that the course's title exists
  validates :title, presence: true

  # Validates that a user started the course.
  validates :user_id, presence: true
end
