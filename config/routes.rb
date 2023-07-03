Rails.application.routes.draw do
  resources :orders, only: [:new, :create, :index] do
    member do
      post 'ready'
      post 'deliver'
      post 'rollback'
    end
  end

  get '/public', to: 'orders#public_index'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "orders#new"
end
