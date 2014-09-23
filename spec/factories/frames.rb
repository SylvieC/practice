# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :frame do
    association :user
    turn1 1
    turn2 1
    game nil
  end
end
