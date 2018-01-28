Rails.application.routes.draw do
  get('/admin', to: 'admin#index')
  # get('/events/new', to: 'events#new')

  resources :news, only: [:index]
  resources :events, only:[:index]
  resources :organizations, only: [:new, :create, :show, :index, :destroy] do
    resources :events, only: [:new, :create, :show, :edit, :update, :destroy], shallow: true
  end

  resources :users, only: [:new, :create, :destroy] do
    resources :organizations, only: [:show, :create, :update], shallow: true
  end
  
  resource :session, only: [:new, :create, :destroy]

  namespace :admin, only: [:index] do
    resources :events, only: [:index, :create, :destroy]
    resources :organizations, only: [:index, :create, :destroy]
    resources :users, only: [:index, :create, :destroy]
  end

  get('/', { to: 'organizations#index', as: :home })

end
