FactoryGirl.define do
  factory :redirect do
    sequence(:shortcut){|n| "shortcut#{n}" }
    sequence(:url){|n| "http://domain#{n}.com/" }
  end
end
