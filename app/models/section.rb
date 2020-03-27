class Section < ApplicationRecord
  has_many :course_contents
  has_many :section_contents
  has_many :lessons, through: :section_contents
  belongs_to :course

  # Validates that the section's title exists
  validates :title, presence: true
end
