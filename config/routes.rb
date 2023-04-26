Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords'
  }
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :workshops , :only => %i[index show]
  resources :bookings  , :only => %i[create] do
    get :booking_details ,on: :member
  end  

  resources :refunds do
    get :refund_acceptance ,on: :member
  end  

  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    resources :workshops
    resources :bookings
    resources :refunds
    resources :customers
  end

end
