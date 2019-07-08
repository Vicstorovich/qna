class Profile < ApplicationRecord
  VALID_EMAIL_GITHAB = /^https:\/\/github\.com\//i.freeze

  belongs_to :user

  validates :user, uniqueness: true
  validate :ensure_url_format

  mount_uploader :avatar, CourseImageUploader

  private

  def ensure_url_format
    return if link =~ VALID_EMAIL_GITHAB

    errors[:link] << "Invalid GitHab url format"
  end
end
