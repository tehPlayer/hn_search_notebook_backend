# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.references :tag, foreign_key: true
      t.references :search_result, foreign_key: true

      t.timestamps
    end
  end
end
