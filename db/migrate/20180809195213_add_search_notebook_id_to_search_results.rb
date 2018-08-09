# frozen_string_literal: true

class AddSearchNotebookIdToSearchResults < ActiveRecord::Migration[5.0]
  def change
    add_reference :search_results, :search_notebook, foreign_key: true
  end
end
