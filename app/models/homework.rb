class Homework < ApplicationRecord
  scope :select_lesson, ->(lesson_id) { where(lesson_id: lesson_id) }
  scope :course_homeworks, ->(course) { joins(:lesson).where(lessons: { course_id: course.id }) }
  scope :by_lesson_homeworks, ->(course, lesson_id) { where(lesson_id: course.lessons.find(lesson_id)) }

  belongs_to :lesson
  belongs_to :user

  validates :body, presence: true
end
