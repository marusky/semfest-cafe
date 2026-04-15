Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :orders, only: [:new, :create, :index, :destroy] do
    member do
      post 'ready'
      post 'deliver'
      post 'rollback'
    end
  end


  get '/public', to: 'orders#public_index'
  get '/spotlight', to: 'pages#spotlight'
  post 'spotlight', to: 'orders#spotlight'

  root "pages#home"
end
