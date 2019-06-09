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

    @funcionario = Funcionario.new
    carregar_tabela(params[:pesquisa])

  end

  def new
    @funcionario = Funcionario.new
  end

  def edit
    @funcionario = Funcionario.find(params[:id])
    @funcionarios = Funcionario.listaFuncionarios
    render 'funcionarios/index'
  end

  def update
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
    @funcionario = Funcionario.new(funcionario_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @funcionario.tipo = 1;

    if @funcionario.save
      @@resultadoPositivoFuncionario = "Funcionário salvo"
      redirect_to
    else
      carregar_tabela('')
      render 'funcionarios/index'
    end

  end

  def destroy
    @funcionario = Funcionario.find(params[:id])
    @funcionario.destroy
    @@resultadoPositivoFuncionario = "Funcionário Deletado";
    redirect_to funcionarios_path
  end

  private
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
