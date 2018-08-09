# frozen_string_literal: true

require 'rails_helper'

describe SearchResults::Destroy do
  subject { described_class.run(params) }

  let!(:search_result) { create(:search_result) }
  let(:search_query) { search_result.search_query }
  let(:params) { {search_result: search_result} }

  it 'removes SearchResult' do
    expect{subject}.to change(SearchResult, :count).by(-1)
  end

  it 'removes SearchQuery' do
    expect{subject}.to change(SearchQuery, :count).by(-1)
  end
end