Rails.application.routes.draw do
  root "landing_pages#landing"


  devise_for :users

  resources :groups, except: [:index] do
    resources :memberships, except: [:index]
  end

  resources :calendars, except: [:index] do
    resources :events, except: [:index]
  end


  get ":username/calendar" => "users#calendar", as: :user_calendar
  get ":username/events" => "users#events", as: :user_events
  get ":username/groups" => "users#groups", as: :user_groups


  get ":username" => "users#show", as: :user
end
