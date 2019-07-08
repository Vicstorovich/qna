class Profile < ApplicationRecord
  # VALID_EMAIL_GITHAB = /^https:\/\/github\.com\//i.freeze

  belongs_to :user

  validates :user, uniqueness: true
  validates :link, link: true
  validates :name, presence: true
  # validate :ensure_url_format
  # validates_with MyCustomLinkValidator

  mount_uploader :avatar, CourseImageUploader

  private

  # def ensure_url_format
  #   return if link =~ VALID_EMAIL_GITHAB

  #   errors[:link] << "Invalid GitHab url format"
  # end
end
