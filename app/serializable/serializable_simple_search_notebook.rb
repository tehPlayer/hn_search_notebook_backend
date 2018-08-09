# frozen_string_literal: true

class SerializableSimpleSearchNotebook < JSONAPI::Serializable::Resource
  type 'search_notebooks'
  attributes :title, :created_at, :updated_at
end
