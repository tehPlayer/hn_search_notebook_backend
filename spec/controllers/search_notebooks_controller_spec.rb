# frozen_string_literal: true

require 'rails_helper'

describe SearchNotebooksController, type: :controller do
  describe '#index' do
    context 'with empty collection' do
      it 'renders successfully' do
        get :index
        expect(response).to be_success
      end

      it 'returns empty collection' do
        get :index
        expect(response_json).to be_empty
      end
    end

    context 'with objects' do
      before do
        create_list(:search_notebook, 2)
      end

      it 'renders successfully' do
        get :index
        expect(response).to be_success
      end

      it 'returns objects' do
        get :index
        expect(response_json.size).to eq(2)
      end
    end
  end

  describe '#show' do
    context 'with not existing object' do
      it 'doesnt render successfully' do
        get :show, params: { id: 999_999 }
        expect(response).not_to be_success
      end
    end

    context 'with objects' do
      let!(:search_notebook) { create(:search_notebook, :with_results) }

      it 'renders successfully' do
        get :show, params: { id: search_notebook.id }
        expect(response).to be_success
      end

      it 'returns objects' do
        get :show, params: { id: search_notebook.id }
        expect(response_json[:id]).to eq(search_notebook.id)
      end

      it 'includes search results' do
        get :show, params: { id: search_notebook.id }
        expect(response_json).to include(:search_results)
      end
    end
  end

  describe '#create' do
    context 'with invalid params' do
      it 'doesnt render successfully for empty params' do
        post :create, params: { search_notebook: {} }
        expect(response).not_to be_success
      end

      it 'doesnt render successfully for blank params' do
        post :create, params: { search_notebook: { title: nil } }
        expect(response).not_to be_success
      end

      it 'returns errors on invalid request' do
        post :create, params: { search_notebook: { title: nil } }
        expect(response_json[:title].first).to eq("can't be blank")
      end
    end

    context 'with valid params' do
      it 'renders successfully' do
        post :create, params: { search_notebook: { title: 'Test' } }
        expect(response).to be_success
      end

      it 'creates object' do
        expect { post :create, params: { search_notebook: { title: 'Test' } } }.to(
          change(SearchNotebook, :count).by(1)
        )
      end

      it 'returns object' do
        post :create, params: { search_notebook: { title: 'Test' } }
        expect(response_json[:id]).to be_present
      end
    end
  end

  describe '#destroy' do
    context 'with not existing object' do
      it 'doesnt render successfully' do
        delete :destroy, params: { id: 999_999 }
        expect(response).not_to be_success
      end
    end

    context 'with existing object' do
      let!(:search_notebook) { create(:search_notebook) }

      it 'renders successfully' do
        delete :destroy, params: { id: search_notebook.id }
        expect(response).to be_success
      end

      it 'removes object' do
        expect { delete :destroy, params: { id: search_notebook.id } }.to(
          change(SearchNotebook, :count).by(-1)
        )
      end
    end
  end
end
