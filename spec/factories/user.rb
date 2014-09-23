FactoryGirl.define do

  factory :user do |f|
    sequence(:email) { |n| "johndoe#{n}@example.com"} 
    password "foobarbar"
    password_confirmation "foobarbar"
  end
  
end
