# frozen_string_literal: true

class SearchResultsController < ApplicationController
  def search
    results_obj = HN::Interface.search(search_params)

    render json: { results: results_obj.body, query: results_obj.url }
  end

  def create
    @search_notebook = SearchNotebook.find(params[:search_notebook_id])
    outcome = SearchResults::Create.run(search_hit_params.merge(search_notebook: @search_notebook))

    if outcome.success?
      render json: { status: 'ok' }
    else
      render json: { status: 'error', details: outcome.errors.symbolic }, status: 422
    end
  end

  def destroy
    search_result = SearchResult.find(params[:id])
    outcome = SearchResults::Destroy.run(search_result: search_result)

    if outcome.success?
      render json: { status: 'ok' }
    else
      render json: { status: 'error', details: outcome.errors.symbolic }, status: 422
    end
  end

  protected

  def search_params
    params.require(:search).permit(:query, :tags, :numericFilters, :page)
  end

  def search_hit_params
    params.require(:search_hit).permit(:author, :points, :url, :query, :nbHits, tag_list: [])
  end
end
