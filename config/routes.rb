Rails.application.routes.draw do

  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/admins/sessions'
  }
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: "homes#top"
  get 'homes/about', to: 'homes#about', as: 'about'
  resources :posts, only: [:index, :show] do
    resource :join, only: [:create, :destroy] 
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root to: 'users#index'
    resources :users, only: [:index, :show, :destroy]
    resources :posts
    resources :comments, only: [:index, :destroy]
    resources :joins, only: [:index]
    get "search" => "searches#search"
  end

  get "search" => "searches#search"


end
