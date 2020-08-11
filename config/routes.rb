# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post :registration, to: 'registration#create'
      post :login, to: 'login#create'
      delete :login, to: 'login#destroy'
      delete 'login/destroy_by_refresh', to: 'login#destroy_by_refresh', as: :destroy_by_refresh
      post :refresh, to: 'refresh#create'
      post :refresh_by_access, to: 'refresh_by_access#create'
      get 'projects/:id/current_tasks', to: 'tasks#show_tasks_by_project'
      patch 'tasks/:id/task_complited', to: 'tasks#task_complited'
      resources :users, only: %i[show create]
      resources :projects
      resources :tasks
      resources :comments, only: %i[create destroy]
    end
  end
end
