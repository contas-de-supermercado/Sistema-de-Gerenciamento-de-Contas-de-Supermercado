class FuncionariosController < ApplicationController

  @@resultadoPositivoFuncionario= ""

  def self.getResultadoPositivoFuncionario
    @@resultadoPositivoFuncionario
  end
  def self.setResultadoPositivoFuncionario valor
    @@resultadoPositivoFuncionario = valor
  end

  def index

    if params[:pesquisa] && params[:pesquisa] != ''
      @funcionarios = Funcionario.pesquisa(params[:pesquisa])
    else
      @funcionarios = Funcionario.listaFuncionarios
    end

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
    @funcionario.update(funcionario_params)
    @@resultadoPositivoFuncionario = "Funcionário Atualizado";
    redirect_to funcionarios_path
  end

  def create
    @funcionario = Funcionario.new(funcionario_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @funcionario.tipo = 1;
    @funcionario.save
    @@resultadoPositivoFuncionario = "Funcionário salvo"
    redirect_to
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
end
