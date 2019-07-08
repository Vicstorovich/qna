class CourseUser < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course, uniqueness: { scope: :user }

  def unsubscribe
    update(ban: true)
  end

  def subscribe
    update(ban: false)
  end
end
