class ContasController < ApplicationController

  def index
    if(params[:pesquisa] &&  params[:pesquisa] != '')
      @clientes = Cliente.pesquisa(params[:pesquisa])
    else
      @clientes = Cliente.listaClientes
    end

    @contasDevendo = [];
    @contasAtrasadas = [];
    @contasPagas = [];

  end

  def show
    carregarContas(params[:id])
    render 'contas/index'
  end

  def edit
    @conta = Conta.find(params[:id])
    @conta.funcionario = Funcionario.find(@conta.funcionario).cpf
    @conta.cliente = Cliente.find(@conta.cliente).cpf
  end

  def destroy
    @conta = Conta.find(params[:id])
    carregarContas(@conta.cliente)
    @conta.destroy
    render 'contas/index'
  end

  private
  def carregarContas id
    contas = Conta.listaContasCliente(id)
    @contasDevendo = contas.listaContasDevendo;
    @contasAtrasadas = contas.listaContasAtrasadas;
    @contasPagas = contas.listaContasPagas;
    @clientes = Cliente.listaClientes
  end

end
