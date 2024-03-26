Rails.application.routes.draw do
  resources :events
  resources :calendars
  devise_for :users
  root "users#dashboard"
end
