class Course < ApplicationRecord
  # No unbounded lessons; only lessons in sections are allowed
  belongs_to :user
  has_many :sections
end
