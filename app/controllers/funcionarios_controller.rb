class FuncionariosController < ApplicationController
  respond_to :js, :html

  @@resultadoPositivoFuncionario= ""

  def self.getResultadoPositivoFuncionario
    @@resultadoPositivoFuncionario
  end
  def self.setResultadoPositivoFuncionario valor
    @@resultadoPositivoFuncionario = valor
  end

  def index
    segurancaLogin(1)
    @funcionario = Funcionario.new
    carregar_tabela(params[:pesquisa])

  end

  def new
    segurancaLogin(1)
    @funcionario = Funcionario.new
  end

  def edit
    segurancaLogin(1)
    @funcionario = Funcionario.find(params[:id])
    @funcionarios = Funcionario.listaFuncionarios
    render 'funcionarios/index'
  end

  def update
    segurancaLogin(1)
    @funcionario = Funcionario.find(params[:id])

    if @funcionario.update(funcionario_params)
      @@resultadoPositivoFuncionario = "Funcionário Atualizado";
      redirect_to funcionarios_path
    else
      carregar_tabela('')
      render 'funcionarios/index'
    end

  end

  def create
    segurancaLogin(1)
    @funcionario = Funcionario.new(funcionario_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @funcionario.tipo = 1
    @funcionario.inativo = 0

    if @funcionario.save
      @@resultadoPositivoFuncionario = "Funcionário salvo"
      redirect_to
    else
      carregar_tabela('')
      render 'funcionarios/index'
    end

  end

  def destroy
    segurancaLogin(1)
    @funcionario = Funcionario.find(params[:id])
    @funcionario.update(tipo: 0)
    @@resultadoPositivoFuncionario = "Funcionário Deletado";
    redirect_to funcionarios_path
  end

  private

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

  def funcionario_params
    params.require(:funcionario).permit(:nome, :cpf, :telefone, :celular, :email, :senha, :cidade, :rua, :numero, :cargo)
  end

  def carregar_tabela(pesquisa)
    if pesquisa && pesquisa != ''
      @funcionarios = Funcionario.pesquisa(pesquisa)
    else
      @funcionarios = Funcionario.listaFuncionarios
    end
  end

end
