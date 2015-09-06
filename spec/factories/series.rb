FactoryGirl.define do
  factory :series do
    name { Faker::Book.title }
  end
end
