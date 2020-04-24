FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'password' }
    password_confirmation { 'password' }
    email { Faker::Internet.email }
    subdomain { Faker::Science.element }
  end
end