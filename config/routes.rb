Rails.application.routes.draw do
  resources :blogs do
    member do
      get :toggle_status
      get :like
      get :dislike
    end
  end

  resources :topics, except: [:update]

  resources :comments do
    member do
      get :like
      get :dislike
    end
  end

  mount ActionCable.server => '/cable'

  resources :portfolios, except: [:show] do
    put :sort, on: :collection
  end
  
  get 'portfolios/:id', to: 'portfolios#show', as: 'portfolio_show'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'tech-news', to: 'pages#tech_news'

  root to: 'pages#home'
end
