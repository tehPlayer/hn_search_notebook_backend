# frozen_string_literal: true

Rails.application.routes.draw do
  resources :search_notebooks, except: %i[new edit update] do
    resources :search_results, only: %i[create destroy] do
      collection do
        post :search
      end
    end
  end
end
