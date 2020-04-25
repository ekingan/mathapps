FactoryBot.define do
  factory :payment do
    amount { Faker::Number.decimal(l_digits: 2) }
    job
  end
end