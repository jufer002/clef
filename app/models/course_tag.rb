class CourseTag < ApplicationRecord
    belongs_to :course
    belongs_to :tag, inverse_of: :course_tags

    validates_presence_of :course
    validates_presence_of :tag

    accepts_nested_attributes_for :tag
end
