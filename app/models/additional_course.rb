class AdditionalCourse < ApplicationRecord
  scope :data_course, ->(course) { find_by(additionable_id: course.id) }

  belongs_to :additionable, polymorphic: true
end
