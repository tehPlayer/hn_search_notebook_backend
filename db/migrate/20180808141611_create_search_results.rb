# frozen_string_literal: true

class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string :login_name, null: false
      t.integer :karma, null: false
      t.string :url, null: false
      t.references :search_query, foreign_key: true

      t.timestamps
    end
  end
end
