# frozen_string_literal: true

class SearchResult < ApplicationRecord
  attr_accessor :tag_list

  belongs_to :search_query
  belongs_to :search_notebook

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :login_name, :karma, :url, presence: true

  before_save :update_tags, unless: -> { tag_list.nil? }

  private

  def update_tags
    new_tags = tag_list.to_a.map(&:downcase)
    if new_tags.any?
      current_tags = tags.pluck(:name)
      outcome = Tags::CollectionUpdate.run(new_tags: new_tags, current_tags: current_tags)
      self.tags = outcome.result
    else
      self.tags = []
    end
    true
  end
end
