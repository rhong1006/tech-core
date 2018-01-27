Rails.application.routes.draw do
  get('/admin', to: 'admin#index')

  resources :organizations, only: [:new, :create, :show, :index] do
    resources :events, only: [:new, :create, :show], shallow: true
  end

  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:create, :destroy]
  resources :events, only:[:index]
  namespace :admin, only: [:index] do
    resources :events, only: [:index]
    resources :organizations, only: [:index]
    resources :users, only: [:index]
  end


end
