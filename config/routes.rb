Rails.application.routes.draw do
  devise_for :usuarios, controllers: {
    sessions: 'usuarios/sessions'
  }
  get 'dashboard/index', as: :dashboard

  resources :reportes, only: [:new] do
    post :cajero, on: :collection
    post :cuenta, on: :collection
  end
  resources :adeudos
  resources :ingreso_por_clasificares, only: [:index]
  resources :emisores, except: [:destroy]
  resources :cajas, except: [:destroy]
  resources :historial_cajas, except: [:edit, :show, :destroy]
  resources :contribuyentes, except: [:destroy]
  resources :cajeros, except: [:destroy]
  resources :cuentas
  resources :cierre_cajas, except: [:new, :destroy] do
    post :cerrar, on: :member
  end
  resources :recibos, only: [:index, :show, :create, :destroy]
  resources :recibo_steps, only: [:show, :update]
  resources :arqueos, except: [:edit, :update, :destroy]
  root 'pages#index'
end
