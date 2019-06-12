Rails.application.routes.draw do

  get 'clientes/perfil'

  resources :funcionarios
  resources :contums
  resources :clientes
  resources :pagamentos

end
