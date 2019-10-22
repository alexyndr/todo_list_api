FactoryBot.define do
  factory :comment do
    sequence :body do |n|
      "Body number_#{n}"
    end
  end
end