Rails.application.routes.draw do
	root to: 'sessions#new'

	resources :users
	resources :sessions
	resources :pages

	get 'index', to: 'sessions#index'
	get 'panel', to: 'sessions#new'
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	get 'logout', to: 'sessions#destroy'
	get 'dashboard', to: 'sessions#index'
end