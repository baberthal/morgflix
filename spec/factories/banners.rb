FactoryGirl.define do
  factory :banner do
    association :series, strategy: :build
    name { 'banners/whatever.jpg' }
  end
end
