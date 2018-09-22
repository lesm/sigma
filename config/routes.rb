Rails.application.routes.draw do
  devise_for :usuarios
  get 'dashboard/index'
  resources :emisores
  resources :contribuyentes
  resources :cierre_cajas, except: [:new, :destroy] do
    post :cerrar, on: :member
  end
  resources :arqueos, except: [:edit, :update, :destroy]
  root 'pages#index'
end
