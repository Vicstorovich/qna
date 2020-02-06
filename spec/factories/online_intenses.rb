FactoryBot.define do
  factory :online_intense do
    name { 'MyCourse' }
    number_hours_video { '3' }
    number_hours_practice { '3' }
    course_start_date { '2019-09-05' }
    course_end_date { '2019-09-07' }
    image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/my_file.jpg'))) }
  end
end
