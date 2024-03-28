Rails.application.routes.draw do
  resources :groups
  resources :memberships
  resources :events
  resources :calendars
  devise_for :users
  root "users#dashboard"
end
