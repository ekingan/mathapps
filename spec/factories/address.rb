FactoryBot.define do
  factory :address do
    sequence(:street) { |n| "{n} Main Street" }
    city { 'Bolton' }
    state { 'MA' }
    zip_code { '01740' }
  end
end