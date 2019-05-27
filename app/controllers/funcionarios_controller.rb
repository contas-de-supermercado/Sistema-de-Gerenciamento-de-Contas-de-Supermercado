class FuncionariosController < ApplicationController

  def index
    @funcionarios = Funcionario.lista_funcionarios
  end

  def new
    @funcionario = Funcionario.new
  end

  def edit
    @funcionario = Funcionario.find(params[:id])
    @funcionarios = Funcionario.lista_funcionarios
    render 'funcionarios/index'
  end

  def update
    @funcionario = Funcionario.find(params[:id])
    @funcionario.update(funcionario_params)
    redirect_to funcionarios_path
  end

  def create
    @funcionario = Funcionario.new(funcionario_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @funcionario.tipo = 1;
    @funcionario.save
    redirect_to
  end

  def destroy
    @funcionario = Funcionario.find(params[:id])
    @funcionario.destroy
    redirect_to funcionarios_path
  end

  private
  def funcionario_params
    params.require(:funcionario).permit(:nome, :cpf, :telefone, :celular, :email, :senha, :cidade, :rua, :numero, :cargo)
  end
end
