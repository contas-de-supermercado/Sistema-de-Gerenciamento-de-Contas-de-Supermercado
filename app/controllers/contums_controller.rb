class ContumsController < ApplicationController
  respond_to :js, :html

  def index
    segurancaLogin(1)

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
    segurancaLogin(1)
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
    segurancaLogin(1)
    carregarContas(params[:id])
    render 'contums/index'
  end

  def edit
    segurancaLogin(1)
    @contum = Contum.find(params[:id])
    @contum.funcionario = Funcionario.find(@contum.funcionario).cpf
    @contum.cliente = Cliente.find(@contum.cliente).cpf
  end

  def update
    segurancaLogin(1)
    @conta = Contum.new(conta_params)

    if(@conta.status == "Paga")
      if(!@conta.dataPagamento || @conta.dataPagamento == '')
        time = Time.now
        @conta.dataPagamento = time;
      end
    end

    @contum = Contum.find(params[:id])
    if @contum.update(valor: @conta.valor, juros: @conta.juros, status: @conta.status, dataPagamento: @conta.dataPagamento,
                      descricao: @conta.descricao, comprador: @conta.comprador, parentesco: @conta.parentesco)
      redirect_to contum_path(@contum.cliente)
    else
      @resultadoConta = "erro-"
    end
  end

  def create
    segurancaLogin(1)
    @contum = Contum.new(conta_params)
    cpfFuncionario = nil
    cpfCliente = nil
    if @contum.funcionario
      cpfFuncionario = @contum.funcionario
      @contum.funcionario = Funcionario.listaFuncionarios.pesquisaCpf(@contum.funcionario)[0].id
    end

    if @contum.cliente
      cpfCliente = @contum.cliente
      @contum.cliente = Cliente.pesquisaCpf(@contum.cliente)[0].id
    end

    time = Time.now
    @contum.dataCompra = time;
    if(@contum.status == "Paga")
      @contum.dataPagamento = time;
    end

    if @contum.save
      redirect_to new_contum_path
    else
      @contum = Contum.new
      @contum.cliente = cpfCliente
      @contum.funcionario = cpfFuncionario
      carregarFuncionarios ''
      carregarClientes ''
      carregarContasData ''
      render 'contums/new'
    end

  end

  def destroy
    segurancaLogin(1)
    @contum = Contum.find(params[:id])
    @contum.destroy
    @resultadoConta = "Conta deletada"
    redirect_to contum_path(@contum.cliente)
  end

  private
  # 0 = index, 1 = new

  def segurancaLogin pessoa
    if pessoa == 1
      if Pessoa.getPessoaLogada().nil? || Pessoa.getPessoaLogada().tipo != 1
        redirect_to logins_path
      end
    else
      if Pessoa.getPessoaLogada().nil? || Pessoa.getPessoaLogada().tipo != 0
        redirect_to logins_path
      end
    end
  end

  def conta_params
    params.require(:contum).permit(:cliente, :funcionario, :valor, :juros, :status, :descricao, :comprador, :parentesco)
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
      data = data.split('/')[2] + '-' + data.split('/')[1] + '-' + data.split('/')[0];
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
