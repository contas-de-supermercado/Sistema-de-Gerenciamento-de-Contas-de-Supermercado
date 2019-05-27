Rails.application.routes.draw do

  get 'ficheiro/index'

  get 'conta/index'

  resources :clientes
  resources :conta
  resources :ficheiro

end
