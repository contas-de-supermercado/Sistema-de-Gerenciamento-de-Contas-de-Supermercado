class ClientesController < ApplicationController
  respond_to :js, :html

  @@resultadoPositivoCliente = ""

  def self.getResultadoPositivoCliente
    @@resultadoPositivoCliente
  end
  def self.setResultadoPositivoCliente valor
    @@resultadoPositivoCliente = valor
  end

  def perfil
    @contasAtrasadas = []
    @contasDevendo = []
    @contasPagas = []
    @cliente.new
  end

  def index
    @cliente = Cliente.new
    carregar_tabela(params[:pesquisa])
  end

  def new
    @cliente = Cliente.new
  end

  def edit
    @cliente = Cliente.find(params[:id])
    @clientes = Cliente.listaClientes
    render 'clientes/index'
  end

  def update
    @cliente = Cliente.find(params[:id])


    if @cliente.update(cliente_params)
      @@resultadoPositivoCliente = "Cliente Atualizado"
      redirect_to clientes_path
    else
      carregar_tabela('')
      render 'clientes/index'
    end

  end

  def create
    @cliente = Cliente.new(cliente_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @cliente.tipo = 0
    @cliente.inativo = 0

    if @cliente.save
      @@resultadoPositivoCliente = "Cliente Salvo"
      redirect_to
    else
      carregar_tabela('')
      render 'clientes/index'
    end
=begin
    if(@cliente.save)
      @@resultadoPositivoCliente = "Cliente Salvo"
    else
      @@resultadoPositivoCliente = "Dados invalidos"
    end

    redirect_to
=end
  end

  def destroy
    @cliente = Cliente.find(params[:id])
    if !verificar_contas_cliente @cliente.id
      @cliente.update(inativo: 1)
      @@resultadoPositivoCliente = "Cliente Deletado";
    else
      @@resultadoPositivoCliente = "erro-O cliente não foi deletado pois ele está devendo contas";
    end

    redirect_to clientes_path
  end

  private

  def carregarContas id
    contas = Contum.listaContasCliente(id)
    @contasDevendo = contas.listaContasDevendo
    @contasAtrasadas = contas.listaContasAtrasadas
    @contasPagas = contas.listaContasPagas
  end

  def cliente_params
    params.require(:cliente).permit(:nome, :cpf, :telefone, :celular, :email, :senha, :cidade, :rua, :numero)
  end

  def carregar_tabela (pesquisa)
    if pesquisa && pesquisa != ''
      @clientes = Cliente.pesquisa(pesquisa)
    else
      @clientes = Cliente.listaClientes
    end
  end

  def verificar_contas_cliente id
    contas = Contum.listaContasCliente(id)
    contasDevendo = contas.listaContasDevendo
    contasAtrasadas = contas.listaContasAtrasadas
    resultado = false
    if contasDevendo.count > 0 || contasAtrasadas.count > 0
      resultado = true
    end
    resultado
  end
end
