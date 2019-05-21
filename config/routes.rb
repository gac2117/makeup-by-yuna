Rails.application.routes.draw do
  root 'welcome#home'

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"

  resources :artists, only: [:index, :show, :new, :create] do
    resources :appointments, only: [:index, :show]
  end

  resources :clients, only: [:index, :show, :new, :create, :edit, :update] do
    resources :appointments, only: [:show, :new, :create, :edit, :update, :destroy]
  end

end
