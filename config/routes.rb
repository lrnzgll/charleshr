Rails.application.routes.draw do
  devise_for :users


  root to: 'pages#main'

  get 'holidays',               to:  'holidays#index'
  post 'holidays/create',       to:  'holidays#create'
  get  'holidays/:id/edit',     to:  'holidays#edit', as: :edit_holiday
  patch 'holidays/update',      to:  'holidays#update'
end
