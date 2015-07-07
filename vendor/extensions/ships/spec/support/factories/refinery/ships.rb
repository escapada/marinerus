
FactoryGirl.define do
  factory :ship, :class => Refinery::Ships::Ship do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

