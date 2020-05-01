class Section < ApplicationRecord
  # Maybe change has_many to has_one :course_contents
  has_many :course_contents
  has_many :section_contents
  has_many :lessons, through: :section_contents
  belongs_to :course, required: false

  # Validates that the section's title exists
  validates :title, presence: true
end
