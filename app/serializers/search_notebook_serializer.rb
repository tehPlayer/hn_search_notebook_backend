# frozen_string_literal: true

class SearchNotebookSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at
end
