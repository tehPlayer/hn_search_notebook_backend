# frozen_string_literal: true

require 'rails_helper'

describe SearchResult do
  context 'tags' do
    let(:tags) { %w{x1 y2 z3} }
    let(:search_result) { create(:search_result, tag_list: tags) }
    let(:new_tags) { %w{x3 y2 z1} }

    it 'creates new tags' do
      expect(search_result.tags.pluck(:name)).to eq(tags)
    end

    it 'updates tags' do
      search_result.update_attributes(tag_list: new_tags)
      expect(search_result.tags.pluck(:name)).to contain_exactly(*new_tags)
    end

    it 'doesnt interfere with tags, when tag_list is nil' do
      search_result.karma = 99999 # just change anything
      search_result.tag_list = nil
      search_result.save!
      expect(search_result.tags.pluck(:name)).to eq(tags)
    end
  end
end