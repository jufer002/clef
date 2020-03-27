class Section < ApplicationRecord
  has_many :lessons, :through => :section_contents

  # Validates that the section's title exists
  validates :title, presence: true
end
