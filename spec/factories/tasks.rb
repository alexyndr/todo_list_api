# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    # association(:project)
    sequence :name do |n|
      "Name_#{n}"
    end
  end

  trait :project do
    association :project
  end
end
