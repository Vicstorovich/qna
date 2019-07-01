class Homework < ApplicationRecord
  scope :select_lessons, ->(lesson_id) { where("lesson_id = ?", lesson_id) }

  belongs_to :lesson
end
