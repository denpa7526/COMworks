Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"
  resources :users, only: [:edit, :update]
  namespace :admin do
    resources :registrations, only: [:new, :create], path: 'sign_up'
    resources :sessions, only: [:new], path: 'sign_in'
  end

end
