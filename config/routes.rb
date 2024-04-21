Rails.application.routes.draw do
  root "landing_pages#landing"


  devise_for :users

  resources :groups do
    resources :memberships, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  resources :calendars do
    resources :events, only: [:show, :new, :create, :edit, :update, :destroy]
  end
 

  get ":username/calendar" => "users#calendar", as: :user_calendar
  get ":username/events" => "users#events", as: :user_events
  get ":username/groups" => "users#groups", as: :user_groups


  get ":username" => "users#show", as: :user
end
