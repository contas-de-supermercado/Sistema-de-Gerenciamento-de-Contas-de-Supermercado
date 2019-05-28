class FicheirosController < ApplicationController
  def index
    @clientes = Cliente.listaClientes
    @funcionarios = Funcionario.listaFuncionarios
  end
end
