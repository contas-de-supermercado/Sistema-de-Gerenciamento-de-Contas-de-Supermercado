class ContumsController < ApplicationController
  respond_to :js, :html

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
    if params[:pesquisaCliente] || params[:pesquisaFuncionario] || params[:pesquisaConta]
      carregarClientes params[:pesquisaCliente]
      carregarFuncionarios params[:pesquisaFuncionario]
      carregarContasData params[:pesquisaConta]
    else
      @clientes = Cliente.listaClientes
      @funcionarios = Funcionario.listaFuncionarios
      @contas = Contum.all
    end

    @contum = Contum.new
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
    @cont.update(valor: @conta.valor, juros: @conta.juros, status: @conta.status, dataPagamento: @conta.dataPagamento,
                 comprador: @conta.comprador, parentesco: @conta.parentesco)
    carregarContas @cont.cliente
    render 'contums/index'
  end

  def create
    @contum = Contum.new(conta_params)

    if @contum.funcionario
      @contum.funcionario = Funcionario.listaFuncionarios.pesquisaCpf(@contum.funcionario)[0].id
    end

    if @contum.cliente
        @contum.cliente = Cliente.pesquisaCpf(@contum.cliente)[0].id
    end

    time = Time.now
    @contum.dataCompra = time;
    if(@contum.status == "Paga")
      @contum.dataPagamento = time;
    end

    if !@contum.juros
      @contum.juros = 0
    end
    if !@contum.valor
      @contum.valor = 0
    end

    if @contum.save
      @@resultadoPositivoFicheiro = "Conta salva"
      redirect_to new_contum_path
    else
      carregarClientes ''
      carregarFuncionarios ''
      render 'contums/new'
    end

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

  def carregarContasData data
    if data && data != ''
      @contas = Contum.listaContasData data
    elsif !data
      @contas = nil;
    else
      @contas = Contum.all
    end
  end

  def carregarClientes pesquisa
    if pesquisa && pesquisa != ''
      @clientes = Cliente.pesquisa(pesquisa);
    elsif !pesquisa
      @clientes = nil
    else
      @clientes = Cliente.listaClientes
    end
  end

  def carregarFuncionarios pesquisa
    if pesquisa && pesquisa != ''
      @funcionarios = Funcionario.pesquisa(pesquisa)
    elsif !pesquisa
      @funcionarios = nil
    else
      @funcionarios = Funcionario.listaFuncionarios
    end
  end

end
