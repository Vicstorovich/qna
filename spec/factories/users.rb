FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password { "12345678" }

    trait :invalid_email do
      email { nil }
    end

    trait :invalid_password do
      password { nil }
    end
  end
end
