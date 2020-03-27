class SectionContent < ApplicationRecord
  has_many :sections
  has_many :lessons
end
