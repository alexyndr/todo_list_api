# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    sequence :name do |n|
      "Name_#{n}"
    end
  end

  trait :user_trait do
    association :user
  end
end
