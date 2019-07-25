class OnlineIntensife < RecordedIntensife
  validates :course_start_date, presence: true
  validates :course_end_date, presence: true
end
