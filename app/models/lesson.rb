class Lesson < ApplicationRecord
  scope :draft, -> { where(draft: false) }
  scope :sort_lessons, -> { order(selector: :asc) }

  belongs_to :course
  has_many :homeworks, dependent: :destroy

  validates :title, presence: true, length: { minimum: 7 }

  mount_uploader :image, LessonImageUploader
  mount_uploader :video, VideoUploader
end
