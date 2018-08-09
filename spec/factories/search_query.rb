# frozen_string_literal: true

FactoryBot.define do
  factory :search_query do
    sequence :query_string do |n|
      "http://hn.algolia.com/api/v1/search?query=foo#{n}&tags=story"
    end
    hits { rand(0..1000) }
  end
end
