FactoryGirl.define do
  factory :list do
    sequence(:title)  { |n| "Title #{n}}" }
    user
  end

end
