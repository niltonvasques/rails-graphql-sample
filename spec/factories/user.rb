# This will guess the User class
FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "User #{n}"
    end
    sequence :email do |n|
      "user-#{n}@example.com"
    end
    password 'foobar'
    password_confirmation 'foobar'
    customer true
    agent false
    admin false
  end
end
