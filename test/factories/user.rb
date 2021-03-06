FactoryBot.define do

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { default_new_password }

    trait :confirmed do
      confirmed_at { DateTime.current }
      password { default_password }
    end

    factory :confirmed_user, traits: [:confirmed]
  end

end