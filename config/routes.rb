Rails.application.routes.draw do
  resources :users
  resources :campaigns
  get 'signup', to: 'users#new'
  get 'run-for-freedom', to: 'landings#run_for_freedom'
end
