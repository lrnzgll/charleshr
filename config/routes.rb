Rails.application.routes.draw do
  devise_for :users


  root to: 'pages#main'

  resources :holidays
  get 'delete_holiday/:id', to: 'holidays#delete_request', as: :delete_holiday

  get 'holiday/:id/events', to: 'holidays#events', as: :holiday_events
end
