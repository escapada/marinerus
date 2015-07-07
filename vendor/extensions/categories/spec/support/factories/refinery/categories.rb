
FactoryGirl.define do
  factory :category, :class => Refinery::Categories::Category do
    sequence(:rutitle) { |n| "refinery#{n}" }
  end
end

