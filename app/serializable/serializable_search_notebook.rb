# frozen_string_literal: true

class SerializableSearchNotebook < SerializableSimpleSearchNotebook
  has_many :search_results
end
