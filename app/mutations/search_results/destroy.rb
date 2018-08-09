# frozen_string_literal: true

module SearchResults
  class Destroy < Mutations::Command
    required do
      model :search_result
    end

    def execute
      search_query = search_result.search_query
      search_result.destroy
      search_query.destroy

      search_result
    end
  end
end
