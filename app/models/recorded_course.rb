class RecordedCourse < Course
  validates :number_hours_video, presence: true
end
