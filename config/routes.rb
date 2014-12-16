Rails.application.routes.draw do

  root 'companies#index'

  get 'recentworks/:days' => 'works#index'

  resources :works
  resources :projects
  resources :users
  resources :companies
end
