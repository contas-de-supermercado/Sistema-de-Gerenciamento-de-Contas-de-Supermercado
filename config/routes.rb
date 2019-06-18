Rails.application.routes.draw do

  get 'logins/index'

  get 'clientes/perfil'

  get 'logins/sair'

  get 'funcionarios/perfil'

  resources :funcionarios
  resources :contums
  resources :clientes
  resources :pagamentos
  resources :logins

  root 'logins#index'

end
