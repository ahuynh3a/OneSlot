Rails.application.routes.draw do
  root "users#dashboard"

  devise_for :users

  resources :groups
  resources :memberships
  resources :events
  resources :calendars
end
