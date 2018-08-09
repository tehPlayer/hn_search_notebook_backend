# frozen_string_literal: true

class CreateSearchQueries < ActiveRecord::Migration[5.0]
  def change
    create_table :search_queries do |t|
      t.string :query_string, null: false
      t.integer :hits, null: false

      t.timestamps
    end
  end
end
