FactoryBot.define do
  factory :profile do
    name { 'Vasia' }

    association :user, factory: :user
  end
end
