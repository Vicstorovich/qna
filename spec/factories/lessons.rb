FactoryBot.define do
  sequence :title do |n|
    "Lesson#{n}"
  end

  factory :lesson do
    course
    title { generate(:title) }

    image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/my_file.jpg'))) }
  end
end
