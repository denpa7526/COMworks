Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "messages#index"

  resources :users, only: [:edit, :update]

  namespace :admin do
    resources :registrations, only: [:new, :create, :destroy], path: 'sign_up'
    resources :sessions, only: [:new, :create, :destroy], path: 'sign_in'
    resources :companies, only: [:show] do
      resource :dashboard, only: [:show]
      resource :shared_password, only: [:new, :create, :edit, :update]
    end
  end

end