# frozen_string_literal: true

class SearchNotebooksController < ApplicationController
  def index
    @notebooks = SearchNotebook.page(params[:page])

    render json: @notebooks
  end

  def show
    @notebook = SearchNotebook.includes(search_results: :tags).find(params[:id])

    render json: @notebook, serializer: SearchNotebookWithResultsSerializer
  end

  def create
    @notebook = SearchNotebook.new(search_notebook_params)

    if @notebook.save
      render json: @notebook
    else
      render json: @notebook.errors, status: 422
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
