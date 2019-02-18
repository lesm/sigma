Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :usuarios, controllers: {
    sessions: 'usuarios/sessions'
  }
  get 'dashboard/index', as: :dashboard

  resources :administradores, except: [:destroy]

  resources :reportes, only: [:new] do
    post :cajero, on: :collection
    post :cuenta, on: :collection
    post :cuentas, on: :collection
  end
  resources :adeudos
  resources :ingreso_por_clasificares, only: [:index]
  resources :emisores, except: [:destroy]
  resources :cajas, except: [:destroy]
  resources :historial_cajas, except: [:edit, :show, :destroy]
  resources :contribuyentes, except: [:destroy] do
    patch :asignar_cuentas, on: :member
  end
  resources :cajeros, except: [:destroy]
  resources :cuentas
  resources :cierre_cajas, except: [:new, :destroy] do
    post :cerrar, on: :member
  end
  resources :recibos, only: [:index, :show, :create, :destroy]
  resources :recibo_steps, only: [:show, :update] do
    get :asignar_cuentas, on: :collection
  end
  resources :arqueos, except: [:edit, :update, :destroy]
  resources :activar_certificados, only: [:new, :create]
  resources :facturas, only: [:index, :show]
  root 'pages#index'
end
