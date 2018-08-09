# frozen_string_literal: true

require 'rails_helper'

describe SearchResultsController, type: :controller do
  let!(:search_notebook) { create(:search_notebook) }

  describe '#search' do
    it 'does something' do
      VCR.use_cassette('hn_search') do
        post :search, params: {search_notebook_id: search_notebook.id, search: {query: 'stephen'}}
      end

      expect(response_json).to be_present
    end
  end

  describe '#create' do
    context 'with invalid params' do
      it 'doesnt render successfully for empty params' do
        post :create, params: {
          search_notebook_id: search_notebook.id,
          search_hit: {}
        }
        expect(response).not_to be_success
      end

      it 'doesnt render successfully for blank params' do
        post :create, params: {
          search_notebook_id: search_notebook.id,
          search_hit: { author: nil }
        }
        expect(response).not_to be_success
      end

      it 'returns error status on invalid request' do
        post :create, params: {
          search_notebook_id: search_notebook.id,
          search_hit: { author: nil }
        }
        expect(response_json[:status]).to eq('error')
        expect(response_json[:details]).to be_present
      end
    end

    context 'with valid params' do
      let(:valid_params) do
        {
          author: 'Test',
          points: 6012,
          tag_list: %w[story whatever],
          url: 'http://localhost:3000',
          query: 'https://hn.algolia.com/api/v1/search?query=stephen',
          nbHits: 21_209
        }
      end

      it 'renders successfully' do
        post :create, params: {
          search_notebook_id: search_notebook.id,
          search_hit: valid_params
        }
        expect(response).to be_success
      end

      it 'creates SearchResult object' do
        expect do
          post :create, params: {
            search_notebook_id: search_notebook.id,
            search_hit: valid_params
          }
        end.to(
          change(SearchResult, :count).by(1)
        )
      end

      it 'creates SearchQuery object' do
        expect do
          post :create,
               params: {
                 search_notebook_id: search_notebook.id,
                 search_hit: valid_params
               }
        end.to(change(SearchQuery, :count).by(1))
      end

      it 'returns object' do
        post :create, params: {
          search_notebook_id: search_notebook.id,
          search_hit: valid_params
        }
        expect(response_json[:status]).to eq('ok')
      end
    end
  end

  describe '#destroy' do
    context 'with not existing object' do
      it 'doesnt render successfully' do
        delete :destroy, params: { search_notebook_id: search_notebook.id, id: 999_999 }
        expect(response).not_to be_success
      end
    end

    context 'with existing object' do
      let!(:search_result) { create(:search_result) }
      let(:search_notebook) { search_result.search_notebook }

      it 'renders successfully' do
        delete :destroy, params: { search_notebook_id: search_notebook.id, id: search_result.id }
        expect(response).to be_success
      end

      it 'removes object' do
        expect do
          delete :destroy,
                 params: {
                   search_notebook_id: search_notebook.id,
                   id: search_result.id
                 }
        end.to(
          change(SearchResult, :count).by(-1)
        )
      end
    end
  end
end
