FactoryBot.define do
    factory :user do
      name { Faker::Internet.username }
      email { Faker::Internet.email }
      password { 'FakePassword123' }
      password_confirmation { 'FakePassword123' }
    end
end