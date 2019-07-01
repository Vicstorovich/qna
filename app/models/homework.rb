class Homework < ApplicationRecord
  scope :select_lessons, ->(lesson_id) { where("lesson_id = ?", lesson_id) }

  belongs_to :lesson
  belongs_to :user
  belongs_to :course

  validates :body, presence: true
end
