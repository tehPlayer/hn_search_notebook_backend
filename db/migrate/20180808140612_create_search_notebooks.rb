# frozen_string_literal: true

class CreateSearchNotebooks < ActiveRecord::Migration[5.0]
  def change
    create_table :search_notebooks do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
