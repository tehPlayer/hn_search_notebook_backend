# frozen_string_literal: true

FactoryBot.define do
  factory :search_notebook do
    sequence :title do |n|
      "Random title ##{n}"
    end

    trait :with_results do
      after(:create) do |notebook|
        create_list(:search_result, 2, search_notebook: notebook)
      end
    end
  end
end
