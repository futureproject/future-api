FactoryGirl.define do

  factory :project do
    sequence(:name) {|n| "epic undertaking #{n}" }
    description "I am a description of this project."
    fellow
  end

  factory :person do
    first_name "Bruce"
    sequence(:last_name){|n| "Wayne #{n}"}
    sequence(:uid) {|s| "123#{s}" }
    admin false
    tag_list "future, project"
    school
  end

  factory :coach, parent: :person, class: "Coach"
  factory :dream_director, parent: :person, class: "DreamDirector" do
    admin true
  end
  factory :lab_tech, parent: :person, class: "LabTech" do
    admin true
  end
  factory :fellow, parent: :person, class: "Fellow"

  factory :school do
    sequence(:name) {|n|"arkham " + (n > 1 ? "annex #{n}" : "academy")}
  end

end

