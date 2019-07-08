class CourseUser < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course, uniqueness: { scope: :user }

  def unsubscribe
    update(pupil: false)
  end

  def subscribe
    update(pupil: true)
  end
end
