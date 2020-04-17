class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :section, required: false
  has_many :sections, :through => :section_contents
  has_many :comments

  # Lesson tag relations
  has_many :lesson_tags
  has_many :tags, through: :lesson_tags

  # Validates that the article's title exists, is long enough, and is unique
  validates :title, presence: true#, length: { minimum: 6 }, uniqueness: true

  # Validates that the article has a sufficient body.
  #validates :body, presence: true, length: { minimum: 10 }

  # Validates that a user wrote the article.
  validates :user_id, presence: true

  # S3 attachments images/audio/video
  has_many_attached :attachments

  # ActionText rich text field
  has_rich_text :body
end
