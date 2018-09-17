Rails.application.routes.draw do
  devise_for :usuarios
  get 'dashboard/index'
  resources :emisores
  resources :contribuyentes
  resources :cierre_cajas, except: [:edit, :update, :destroy]
  resources :arqueos, except: [:edit, :update, :destroy]
  root 'pages#index'
end
