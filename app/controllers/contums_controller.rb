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
    segurancaLogin(1)
    if @@telaAbertaConta == 1
      @@resultadoPositivoFicheiro = ""
    end
    @@telaAbertaConta = 0;

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
    if @@telaAbertaConta == 0
      @@resultadoPositivoFicheiro = ""
    end
    @@telaAbertaConta = 1
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

    if !@conta.juros
      @conta.juros = 0
    end
    if !@conta.valor
      @conta.valor = 0
    end

    @cont = Contum.find(params[:id])
    @cont.update(valor: @conta.valor, juros: @conta.juros, status: @conta.status, dataPagamento: @conta.dataPagamento,
                 descricao: @conta.descricao, comprador: @conta.comprador, parentesco: @conta.parentesco)
    carregarContas @cont.cliente

    @@resultadoPositivoFicheiro = "Conta Atualizada"
    if @@telaAbertaConta == 0
      carregarContas(@cont.cliente)
      render 'contums/index'
    elsif @@telaAbertaConta == 1
      @contum = Contum.new
      carregarFuncionarios ''
      carregarClientes ''
      carregarContasData ''
      render 'contums/new'
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
      @@resultadoPositivoFicheiro = "Conta salva"
      redirect_to new_contum_path
    else
      carregarClientes ''
      carregarFuncionarios ''
      carregarContasData ''
      @contum.funcionario = cpfFuncionario
      @contum.cliente = cpfCliente
      render 'contums/new'
    end

  end

  def destroy
    segurancaLogin(1)
    @contum = Contum.find(params[:id])
    @contum.destroy
    @@resultadoPositivoFicheiro = "Conta Deletada"
    if @@telaAbertaConta == 0
      carregarContas(@contum.cliente)
      render 'contums/index'
    elsif @@telaAbertaConta == 1
      @contum = Contum.new
      carregarFuncionarios ''
      carregarClientes ''
      carregarContasData ''
      render 'contums/new'
    end
  end

  private
  # 0 = index, 1 = new
  @@telaAbertaConta = -1

  def segurancaLogin pessoa
    if pessoa == 1
      if Pessoa.getPessoaLogada() == nil || Pessoa.getPessoaLogada().tipo != 1
        redirect_to logins_path
      end
    else
      if Pessoa.getPessoaLogada() == nil || Pessoa.getPessoaLogada().tipo != 0
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
