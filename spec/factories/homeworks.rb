FactoryBot.define do
  sequence :body do |n|
    "Homework#{n}"
  end

  factory :homework do
    body { generate(:body) }

    trait :invalid do
      body { nil }
    end
  end
end
