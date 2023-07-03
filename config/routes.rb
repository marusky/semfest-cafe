Rails.application.routes.draw do
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
