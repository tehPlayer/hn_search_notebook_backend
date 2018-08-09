# frozen_string_literal: true

class SerializableSearchResult < JSONAPI::Serializable::Resource
  type 'search_results'
  attributes :login_name, :karma, :url, :created_at, :updated_at
  attribute :tags do
    @object.tags.map(&:name)
  end
end
