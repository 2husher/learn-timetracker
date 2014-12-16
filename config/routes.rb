Rails.application.routes.draw do

  root 'companies#index'

  get 'recentworks/:days' => 'works#index'

  get 'timetrackerprojects/:slug' => 'projects#show'

  resources :works
  resources :projects
  resources :companies
end
