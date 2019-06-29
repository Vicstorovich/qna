class Lesson < ApplicationRecord
  scope :draft, -> { where(draft: false) }

  belongs_to :course

  validates :title, presence: true, length: { minimum: 7 }

  mount_uploader :image, LessonImageUploader
  mount_uploader :video, VideoUploader
end
