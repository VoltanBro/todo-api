# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json },
                     path: "/api/v1/",
                     controllers: {
                 sessions: "api/v1/sessions",
                 registrations: "api/v1/registrations"
             }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        resources :projects
      end
    end
  end
end
