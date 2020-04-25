FactoryBot.define do
  factory :job do
    job_type { 'tax_return' }
    price { Faker::Number.decimal(l_digits: 2) }
    paid_in_full { false }
    status { 'ready' }
    user
    client
  end
end