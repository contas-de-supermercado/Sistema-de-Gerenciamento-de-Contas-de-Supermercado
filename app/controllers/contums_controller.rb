class ContumsController < ApplicationController

  @@resultadoPositivoFicheiro = ""

  def self.getResultadoPositivoFicheiro
    @@resultadoPositivoFicheiro
  end
  def self.setResultadoPositivoFicheiro valor
    @@resultadoPositivoFicheiro  = valor
  end

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

  def new
    if params[:pesquisaCliente] && params[:pesquisaCliente] != ''
      @clientes = Cliente.pesquisa(params[:pesquisaCliente])
    else
      @clientes = Cliente.listaClientes
    end

    if params[:pesquisaFuncionario] && params[:pesquisaFuncionario] != ''
      @funcionarios = Funcionario.pesquisa(params[:pesquisaFuncionario])
    else
      @funcionarios = Funcionario.listaFuncionarios
    end

  end

  def show
    carregarContas(params[:id])
    render 'contums/index'
  end

  def edit
    @contum = Contum.find(params[:id])
    @contum.funcionario = Funcionario.find(@contum.funcionario).cpf
    @contum.cliente = Cliente.find(@contum.cliente).cpf
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
        render 'contums/index'
      end
    end
  end

  def create
    @conta = Contum.new(conta_params)
    funcionario = Funcionario.listaFuncionarios.pesquisaCpf(@conta.funcionario)
    if @conta.funcionario && funcionario.count > 0
      @conta.funcionario = funcionario[0].id

      cliente = Cliente.pesquisaCpf @conta.cliente
      if @conta.cliente && cliente.count > 0
        @conta.cliente = cliente[0].id

        time = Time.now
        @conta.dataCompra = time;
        if(@conta.status == "Paga")
          @conta.dataPagamento = time;
        end

        @@resultadoPositivoFicheiro = "Contum salva"
        if !@conta.juros
          @conta.juros = 0
        end
        if !@conta.valor
          @conta.valor = 0
        end
        @conta.save
      end
    end

    redirect_to new_contum_path
  end

  def destroy

    @conta = Contum.find(params[:id])
    carregarContas(@conta.cliente)
    @conta.destroy
    render 'contums/index'
  end

  private
  def conta_params
    params.require(:contum).permit(:cliente, :funcionario, :valor, :juros, :status, :comprador, :parentesco)
  end

  def carregarContas id

    contas = Contum.listaContasCliente(id)
    @contasDevendo = contas.listaContasDevendo
    @contasAtrasadas = contas.listaContasAtrasadas
    @contasPagas = contas.listaContasPagas
    @clientes = Cliente.listaClientes
  end

end
