Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        post 'sign_up', to: 'users#create'
        post 'sign_in', to: 'users#show'
      end

      resources :projects, only: [:create, :update, :destroy] do
        resources :tasks, only: [:create, :update, :destroy] do
          resources :comments, only: [:create, :destroy]
        end
      end
    end
  end
end
