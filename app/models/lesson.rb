class Lesson < ApplicationRecord
  belongs_to :user
  has_many :comments

  ################
  # Validations #
  ################

  # Validates that the article's title
  validates :title, presence: true, length: { minimum: 6 }, uniqueness: true

  # Validates that the article has a sufficient body.
  validates :body, presence: true, length: { minimum: 10 }

  # Validates that a user wrote the article.
  validates :user_id, presence: true

end
