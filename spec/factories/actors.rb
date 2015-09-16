FactoryGirl.define do
  factory :actor do
    tvdb_actor_id '135751'
    association :series, strategy: :build

    trait :with_info do
      name { Faker::Name.name }
      role { Faker::Name.name }
      image { "/actors/#{tvdb_actor_id}.jpg" }
      sequence(:sort_order) { |n| n }
    end
  end
end
