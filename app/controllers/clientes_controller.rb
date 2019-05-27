class ClientesController < ApplicationController

  def index
    @clientes = Cliente.lista_clientes
  end

  def new
    @cliente = Cliente.new
  end

  def edit
    @cliente = Cliente.find(params[:id])
    @clientes = Cliente.lista_clientes
    render 'clientes/index'
  end

  def update
    @cliente = Cliente.find(params[:id])
    @cliente.update(cliente_params)
    redirect_to clientes_path
  end

  def create
    @cliente = Cliente.new(cliente_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @cliente.tipo = 0;
    @cliente.save
    redirect_to
  end

  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy
    redirect_to clientes_path
  end

  private
  def cliente_params
    params.require(:cliente).permit(:nome, :cpf, :telefone, :celular, :email, :senha, :cidade, :rua, :numero)
  end
end
