FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'asecretpassw0rd'
    password_confirmation 'asecretpassw0rd'
  end
end
