# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :all

  mount Rswag::Ui::Engine,  at: :apidoc
  mount Rswag::Api::Engine, at: :apidoc

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :projects do
        resources :tasks, shallow: true do
          scope module: :tasks do
            resources :position, only: :update
            resources :complete, only: :update
          end
          resources :comments
        end
      end
    end
  end
end
