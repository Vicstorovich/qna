FactoryBot.define do
  factory :recorded_course do
    name { "MyCourse" }
    number_hours_video { '3' }
    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/my_file.jpg')))}
  end
end
