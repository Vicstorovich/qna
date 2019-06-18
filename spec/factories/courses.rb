FactoryBot.define do
  sequence :name do |n|
    "MyCourse#{n}"
  end

  factory :course do
    name

    trait :invalid do
      name { nil }
    end
  end
end
