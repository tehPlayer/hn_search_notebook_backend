# frozen_string_literal: true

require 'rails_helper'

describe SearchResults::Create do
  subject { described_class.run(params) }

  let(:search_notebook) { create(:search_notebook) }
  let(:search_results_params) do
    {
      author: 'test',
      points: 1230,
      url: 'http://localhost:3000',
      tag_list: %w{story test}
    }
  end
  let(:search_query_params) do
    {
      query: 'https://hn.algolia.com/api/v1/search?query=stephen',
      nbHits: 98765
    }
  end
  let(:params) do
    {
      search_notebook: search_notebook
    }.merge(search_results_params).merge(search_query_params)
  end

  context 'for SearchResult' do
    it 'creates successfully' do
      expect{subject}.to change(SearchResult, :count).by(1)
    end

    it 'correctly maps params' do
      r = subject.result
      expect(r.attributes.values_at('login_name', 'karma', 'url')).to eq(
        search_results_params.values_at(:author, :points, :url)
      )
    end

    it 'correctly matches tags' do
      r = subject.result
      expect(r.tags.pluck(:name)).to eq(search_results_params[:tag_list])
    end
  end

  context 'for SearchQuery' do
    it 'creates successfully SearchQuery' do
      expect{subject}.to change(SearchQuery, :count).by(1)
    end

    it 'correctly maps params' do
      r = subject.result.search_query
      expect(r.attributes.values_at('query_string', 'hits')).to eq(
        search_query_params.values_at(:query, :nbHits)
      )
    end
  end
end