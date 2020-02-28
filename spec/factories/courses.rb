FactoryBot.define do
  sequence :name do |n|
    "MyCourse#{n}"
  end

  factory :course do
    name { generate(:name) }

    image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/my_file.jpg'))) }
  end
end
