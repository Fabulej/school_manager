Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }, :path_prefix => 'my'

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  root 'home#index'

  resources :users, only: [:index, :show, :update, :edit, :destroy]
  get "/grades/generate" => "grades#generate", as: "generate"
  get "/grades/download_csv"
  get "/grades/history"
  resources :subjects
  resources :school_classes
  resources :grades

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
