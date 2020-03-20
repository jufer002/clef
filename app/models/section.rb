class Section < ApplicationRecord
    has_many :course_contents
    has_many :courses, :through => :course_contents
    has_many :section_contents
    has_many :lessons, :through => :section_contents

  # Validates that the article's title exists, is long enough and is unique
  validates :title, presence: true, length: { minimum: 6 }, uniqueness: true

  # Validates that a user started the section.
  validates :user_id, presence: true

end
