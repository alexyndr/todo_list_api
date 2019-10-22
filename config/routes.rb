Rails.application.routes.draw do
  devise_for :users, skip: :all

  mount Rswag::Ui::Engine, at: :apidoc

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :projects do
        resources :tasks, shallow: true do
          resources :comments
          patch 'complete', to: 'tasks#update_complete'
          patch 'position', to: 'tasks#update_position'
        end
      end
    end
  end
end
