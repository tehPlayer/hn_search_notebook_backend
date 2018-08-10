# frozen_string_literal: true

class SearchResultSerializer < ActiveModel::Serializer
  attributes :id, :login_name, :karma, :url, :tags

  def tags
    object.tags.map(&:name)
  end
end
