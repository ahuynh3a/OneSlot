Rails.application.routes.draw do
  root "landing_pages#landing"


  devise_for :users

  resources :groups
  resources :memberships
  resources :events
  resources :calendars

  get "/:username" => "users#show", as: :user
end
