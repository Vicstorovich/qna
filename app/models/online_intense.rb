class OnlineIntense < Course
  validates :course_start_date, presence: true
  validates :course_end_date, presence: true
  validates :number_hours_practice, presence: true
  validates :number_hours_video, presence: true
end
