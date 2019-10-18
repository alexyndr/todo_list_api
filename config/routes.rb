Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :tasks, shallow: true do
          resources :comments
          patch 'complete', to: 'tasks#update'
          patch 'position', to: 'tasks#update'
        end
      end
    end
  end
end
