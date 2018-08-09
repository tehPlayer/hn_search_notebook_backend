# frozen_string_literal: true

class SearchQuery < ApplicationRecord
  has_one :search_result, dependent: :destroy

  validates :query_string, :hits, presence: true
end
