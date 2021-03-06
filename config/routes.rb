Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/privacy_policy', to: 'static_pages#privacy_policy'
  get  '/signup',  to: 'users#new'
  get  '/search',  to: 'static_pages#search'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :videoposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  get  "users/:id/likes", to: "users#likes"
  post "likes/:videopost_id/create",  to: "likes#create"
  post "likes/:videopost_id/destroy", to: "likes#destroy"
end
