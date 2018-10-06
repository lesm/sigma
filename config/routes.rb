Rails.application.routes.draw do
  devise_for :usuarios
  get 'dashboard/index'

  resources :adeudos
  resources :emisores
  resources :contribuyentes
  resources :cajeros
  resources :cierre_cajas, except: [:new, :destroy] do
    post :cerrar, on: :member
  end
  resources :recibos, only: [:index, :show, :create, :destroy]
  resources :recibo_steps, only: [:show, :update]
  resources :arqueos, except: [:edit, :update, :destroy]
  root 'pages#index'
end
