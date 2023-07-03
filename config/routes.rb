Rails.application.routes.draw do
  resources :orders, only: [:new, :create, :index] do
    member do
      post 'ready'
      post 'deliver'
      post 'rollback'
    end
  end

  get '/public', to: 'orders#public_index'

  root "pages#home"
end
