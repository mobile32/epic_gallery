Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'

  namespace :admin_panel do
    resources :users, only: :index
  end
end
