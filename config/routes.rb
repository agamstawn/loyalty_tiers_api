Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do

      post 'orders/create',  to: 'orders#create'
      
      resources :orders, only: [:show, :update] do
        member do
          post 'approve'
        end
      end

      resources :customers, only: [:show] do
        get 'orders_since_last_year', on: :member
      end
    end
    
  end
end
