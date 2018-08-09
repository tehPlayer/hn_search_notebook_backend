# frozen_string_literal: true

class SearchNotebook < ApplicationRecord
  has_many :search_results, dependent: :destroy

  validates :title, presence: true
end
