class RecordedIntense < Course
  validates :number_hours_practice, presence: true
  validates :number_hours_video, presence: true
end
