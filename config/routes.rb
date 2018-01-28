Rails.application.routes.draw do
  get('/admin', to: 'admin#index')
  get('/events/new', to: 'events#new')

  resources :news, only: [:index]

  resources :organizations, only: [:new, :create, :show, :index] do
    resources :events, only: [:new, :create, :show], shallow: true
  end

  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :events, only:[:index, :create, :destroy]
  namespace :admin, only: [:index] do
    resources :events, only: [:index, :create, :destroy]
    resources :organizations, only: [:index, :create, :destroy]
    resources :users, only: [:index, :create, :destroy]
  end

  get('/', { to: 'organizations#index', as: :home })

end
