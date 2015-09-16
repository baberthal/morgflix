FactoryGirl.define do
  factory :banner do
    association :series, strategy: :build
    banner_path { 'banners/whatever.jpg' }
  end
end
