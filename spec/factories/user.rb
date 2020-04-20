FactoryBot.define do
  factory :user do
    first_name { 'Usor' }
    last_name { 'Clivar' }
    password { 'password' }
    password_confirmation { 'password' }
    sequence :email do |n|
      "email#{n}@example.com"
    end
    subdomain { 'pizza' }
  end
end