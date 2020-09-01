Rails.application.routes.draw do
  resources :portfolios, except: [:show]
  get 'angular', to: 'portfolios#angular_items'
  get 'rails', to: 'portfolios#rails_items'
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'

  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :blogs do
  	member do
  		get :toggle_status
  	end
  end

  root to: 'pages#home'
end
