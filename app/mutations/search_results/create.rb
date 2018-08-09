# frozen_string_literal: true

module SearchResults
  class Create < Mutations::Command
    required do
      model :search_notebook

      string :author
      integer :points
      string :url
      array :tag_list, class: String
      string :query
      integer :nbHits
    end

    def execute
      search_result = search_notebook.search_results.new(search_results_params)
      search_result.build_search_query(search_query_params)
      search_result.save

      search_result
    end

    private

    def search_results_params
      {
        login_name: author,
        karma: points,
        url: url,
        tag_list: tag_list
      }
    end

    def search_query_params
      {
        query_string: query,
        hits: nbHits
      }
    end
  end
end
