# This will guess the User class
FactoryGirl.define do
  factory :request do
    sequence :title do |n|
      "title #{n}"
    end
    sequence :content do |n|
      "content #{n}"
    end
    user
  end
end
