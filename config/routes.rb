Rails.application.routes.draw do
  get('/admin', to: 'admin#index')

  resources :news, only: [:index]

  resources :organizations, only: [:new, :create, :show, :index] do
    resources :events, only: [:new, :create, :show], shallow: true
  end

  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :events, only:[:index]
  namespace :admin, only: [:index] do
    resources :events, only: [:index, :create, :destroy]
    resources :organizations, only: [:index, :create, :destroy]
    resources :users, only: [:index, :create, :destroy]
  end

  get('/', { to: 'events#index', as: :home })


end
