Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'signup', to: 'users/registrations#new'
  end

  get 'run-for-freedom', to: 'landings#run_for_freedom'
  get 'teachers', to: 'landings#teachers'

  resources :campaigns, only: [:index]
  resources :campaigns, path: '', except: [:index] do
    resources :donations
  end

  root to: 'home#index'
end
