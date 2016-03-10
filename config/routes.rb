Rails.application.routes.draw do
  devise_for :users

  root 'contacts#new'

  resources :contacts, only: [:new, :create]

  resources :newsletters, only: [:index, :edit, :update]
end
