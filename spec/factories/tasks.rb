FactoryBot.define do
  factory :task do
    # association(:project)
    sequence :name do |n|
      "Name_#{n}"
    end
  end
end