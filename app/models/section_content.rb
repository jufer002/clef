class SectionContent < ApplicationRecord
  belongs_to :section, required: false
  belongs_to :lesson
end
