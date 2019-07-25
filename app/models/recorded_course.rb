class RecordedCourse < AdditionalCourse
  validates :number_hours_video, presence: true
end
