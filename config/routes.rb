Rails.application.routes.draw do
  resources :calendars
  devise_for :users
  root "users#dashboard"
end
