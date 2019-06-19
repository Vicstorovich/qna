FactoryBot.define do
  sequence :name do |n|
    "MyCourse#{n}"
  end

  factory :course do
    name

    image {Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/assets/my_file.jpg')))}

    trait :invalid do
      name { nil }
    end
  end
end
