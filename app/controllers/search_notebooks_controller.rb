# frozen_string_literal: true

class SearchNotebooksController < ApplicationController
  def index
    @notebooks = SearchNotebook.page(params[:page])

    render jsonapi: @notebooks, class: { SearchNotebook: SerializableSimpleSearchNotebook }
  end

  def show
    @notebook = SearchNotebook.includes(search_results: :tags).find(params[:id])

    render  jsonapi: @notebook,
            include: { search_results: :tags }
  end

  def create
    @notebook = SearchNotebook.new(search_notebook_params)

    if @notebook.save
      render jsonapi: @notebook, class: { SearchNotebook: SerializableSimpleSearchNotebook }
    else
      render jsonapi_errors: @notebook.errors, status: 422
    end
  end

  def destroy
    @notebook = SearchNotebook.find(params[:id])

    @notebook.destroy

    render json: { status: 'ok' }
  end

  def statistics; end

  protected

  def search_notebook_params
    params.require(:search_notebook).permit(:title)
  end
end
