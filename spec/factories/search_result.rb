# frozen_string_literal: true

FactoryBot.define do
  factory :search_result do
    association :search_query
    association :search_notebook
    sequence :login_name do |n|
      "Author#{n}"
    end
    sequence :url do |_n|
      "https://news.ycombinator.com/item?id=#{rand(0..999_999)}"
    end
    karma { rand(-100..100) }
    tag_list { Array.new(5) { |x| "tag#{x}" }.sample(rand(0..5)) }
  end
end
