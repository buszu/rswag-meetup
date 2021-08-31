# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root to: 'about#show'
      resource :about, only: :show, controller: :about
    end
  end
end
