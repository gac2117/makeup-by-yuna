Rails.application.routes.draw do
  root 'welcome#home'

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  get '/auth/facebook/callback' => 'sessions#create'
  delete "/signout", to: "sessions#destroy"

  resources :clients, only: [:index, :show, :new, :create, :edit, :update] do
    resources :appointments
  end

  resources :appointments, only: [:index, :create, :update]

  resources :artists, only: [:index, :show, :new, :create, :edit, :update] do
    resources :appointments, only: [:index, :show]
  end

end
