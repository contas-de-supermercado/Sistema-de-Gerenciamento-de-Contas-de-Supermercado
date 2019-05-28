Rails.application.routes.draw do

  get 'ficheiros/index'

  resources :clientes

  resources :funcionarios

  resources :contas

  resources :ficheiros

end
