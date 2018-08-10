# frozen_string_literal: true

class SearchNotebookWithResultsSerializer < SearchNotebookSerializer
  has_many :search_results
end
