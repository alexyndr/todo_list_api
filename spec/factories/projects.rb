FactoryBot.define do
  factory :project do
    sequence :name do |n|
      "Name_#{n}"
    end
  end
end