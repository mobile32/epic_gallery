Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'galleries#index'

  namespace :admin_panel do
    resources :users, only: :index
  end

  resources :galleries
  resources :uploads
end
