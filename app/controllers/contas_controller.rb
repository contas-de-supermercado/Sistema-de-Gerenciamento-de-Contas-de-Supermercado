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
    @conta = Contum.find(params[:id])
    @conta.funcionario = Funcionario.find(@conta.funcionario).cpf
    @conta.cliente = Cliente.find(@conta.cliente).cpf
  end

  def update
    @conta = Contum.new(conta_params)
    funcionario = Funcionario.pesquisaCpf @conta.funcionario
    if @conta.funcionario && funcionario.count > 0
      @conta.funcionario = funcionario[0].id

      cliente = Cliente.pesquisaCpf @conta.cliente
      if @conta.cliente && cliente.count > 0
        @conta.cliente = cliente[0].id

        if(@conta.status == "Paga")
          if(@conta.dataPagamento == '')
            time = Time.now
            @conta.dataPagamento = time;
          end
        end

        if !@conta.juros
          @conta.juros = 0
        end
        if !@conta.valor
          @conta.valor = 0
        end

        @cont = Contum.find(params[:id])
        @cont.update(cliente: @conta.cliente,funcionario: @conta.funcionario, valor: @conta.valor, juros: @conta.juros,
                     status: @conta.status, dataPagamento: @conta.dataPagamento,
                     comprador: @conta.comprador, parentesco: @conta.parentesco)
        carregarContas @conta.cliente
        render 'contas/index'
      end
    end
  end

  def destroy
    @conta = Contum.find(params[:id])
    carregarContas(@conta.cliente)
    @conta.destroy
    render 'contas/index'
  end

  private
  def conta_params
    params.require(:conta).permit(:cliente, :funcionario, :valor, :juros, :status, :comprador, :parentesco)
  end

  def carregarContas id
    contas = Contum.listaContasCliente(id)
    @contasDevendo = contas.listaContasDevendo;
    @contasAtrasadas = contas.listaContasAtrasadas;
    @contasPagas = contas.listaContasPagas;
    @clientes = Cliente.listaClientes
  end

end
