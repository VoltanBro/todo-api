# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post :registration, to: 'registration#create'
      post :login, to: 'login#create'
      delete :login, to: 'login#destroy'
      delete 'login/destroy_by_refresh', to: 'login#destroy_by_refresh', as: :destroy_by_refresh
      post :login_with_cookies, to: 'login_with_cookies#create'
      post :refresh, to: 'refresh#create'
      post :refresh_by_access, to: 'refresh_by_access#create'
      resources :users, only: [:show, :create]
      resources :projects do
        resources :tasks
      end
    end
  end
end
