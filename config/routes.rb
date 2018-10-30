Rails.application.routes.draw do
  resources :users
  resources :sessions
  get 'login', to: 'sessions#new'
  get 'signup', to: 'users#new'
  get 'run-for-freedom', to: 'landings#run_for_freedom'
  get 'teachers', to: 'landings#teachers'
  resources :campaigns, path: '', except: [:index] do
    resources :donations
  end
end
