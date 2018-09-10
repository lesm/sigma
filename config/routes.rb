Rails.application.routes.draw do
  devise_for :usuarios
  get 'dashboard/index'
  resources :contribuyentes
  root 'pages#index'
end
