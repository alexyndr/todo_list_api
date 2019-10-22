Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
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
