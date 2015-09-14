series_names = [
  'Game of Thrones',
  'Last Week Tonight',
  'House',
  'The Brink'
]

FactoryGirl.define do
  factory :series do
    name 'Archer (2009)'

    trait :with_random_name do
      name { series_names.sample }
    end

    factory :random_series, traits: [:with_random_name]
  end
end
