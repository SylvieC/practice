# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    
    is_completed false
    user nil
    association :user
  end
end
