
FactoryGirl.define do
  factory :siteclient, :class => Refinery::Siteclients::Siteclient do
    sequence(:email) { |n| "refinery#{n}" }
  end
end

