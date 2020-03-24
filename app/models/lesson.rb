class Lesson < ApplicationRecord
    belongs_to :user
    has_many :section_contents
    has_many :section, :through => :section_contents
    has_many :comments

  # Validates that the article's title exists, is long enough, and is unique
  validates :title, presence: true#, length: { minimum: 6 }, uniqueness: true

  # Validates that the article has a sufficient body.
  validates :body, presence: true, length: { minimum: 10 }

  # Validates that a user wrote the article.
  validates :user_id, presence: true
end
