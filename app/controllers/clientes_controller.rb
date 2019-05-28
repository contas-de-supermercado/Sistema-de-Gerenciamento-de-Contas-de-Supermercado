class ClientesController < ApplicationController

  @@resultadoPositivoCliente = ""

  def self.getClienteSalvo
    @@resultadoPositivoCliente
  end
  def self.setClienteSalvo valor
    @@resultadoPositivoCliente = valor
  end

  def index

    if params[:pesquisa] && params[:pesquisa] != ''
      @clientes = Cliente.pesquisa(params[:pesquisa])
    else
      @clientes = Cliente.listaClientes 0
    end

  end

  def new
    @cliente = Cliente.new
  end

  def edit
    @cliente = Cliente.find(params[:id])
    @clientes = Cliente.listaClientes 0
    render 'clientes/index'
  end

  def update
    @cliente = Cliente.find(params[:id])
    @cliente.update(cliente_params)
    @@resultadoPositivoCliente = "Cliente Atualizado"
    redirect_to clientes_path
  end

  def create
    @cliente = Cliente.new(cliente_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @cliente.tipo = 0
    @@resultadoPositivoCliente = "Cliente Salvo"
    @cliente.save
    redirect_to
  end

  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy
    @@resultadoPositivoCliente = "Cliente Deletado";
    redirect_to clientes_path
  end

  private
  def cliente_params
    params.require(:cliente).permit(:nome, :cpf, :telefone, :celular, :email, :senha, :cidade, :rua, :numero)
  end
end
