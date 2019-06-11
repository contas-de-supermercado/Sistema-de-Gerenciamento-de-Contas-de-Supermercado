class PagamentosController < ApplicationController

  def index
    if(params[:pesquisa] &&  params[:pesquisa] != '')
      @clientes = Cliente.pesquisa(params[:pesquisa])
    else
      @clientes = Cliente.listaClientes
    end

    @contasDevendo = [];
    @contasAtrasadas = [];
    @cliente = Cliente.new
  end

  def show
    carregarContas(params[:id])
    @cliente = Cliente.find(params[:id])
    render 'pagamentos/index'
  end


  private

  def carregarContas id
    contas = Contum.listaContasCliente(id)
    @contasDevendo = contas.listaContasDevendo
    @contasAtrasadas = contas.listaContasAtrasadas
    @clientes = Cliente.listaClientes
  end
end
