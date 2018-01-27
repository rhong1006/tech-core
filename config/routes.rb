Rails.application.routes.draw do

  resources :organizations, only: [:new, :create, :show, :index] do
    resources :events, only: [:new, :create, :show], shallow: true
  end

  get('/filtered_organizations', { to: 'organizations#filtered_organizations', as: :filter })

  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:create, :destroy]
  resources :events, only:[:index]

end
