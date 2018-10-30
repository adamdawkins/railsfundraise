Rails.application.routes.draw do
  resources :users
  get 'signup', to: 'users#new'
  get 'run-for-freedom', to: 'landings#run_for_freedom'
  resources :campaigns, path: '', except: [:index]
end
