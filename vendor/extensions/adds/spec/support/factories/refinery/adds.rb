
FactoryGirl.define do
  factory :add, :class => Refinery::Adds::Add do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

