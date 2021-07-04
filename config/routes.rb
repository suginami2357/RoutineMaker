Rails.application.routes.draw do
  root 'routines#top'

  resources :users

  post    '/login'      => 'sessions#create'
  get     '/login/new'  => 'sessions#new'
  delete  '/logout'     => 'sessions#destroy'
  
  resources :routines
end
