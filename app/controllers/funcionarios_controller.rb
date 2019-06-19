class FuncionariosController < ApplicationController
  respond_to :js, :html

  @@resultadoPositivoFuncionario= ""

  def self.getResultadoPositivoFuncionario
    @@resultadoPositivoFuncionario
  end
  def self.setResultadoPositivoFuncionario valor
    @@resultadoPositivoFuncionario = valor
  end

  def perfil
    segurancaLogin(1)
    @funcionario = Pessoa.getPessoaLogada
  end

  def index
    segurancaLogin(11)
    @funcionario = Funcionario.new
    carregar_tabela(params[:pesquisa])

  end

  def new
    segurancaLogin(11)
    @funcionario = Funcionario.new
  end

  def edit
    segurancaLogin(11)
    @funcionario = Funcionario.find(params[:id])
    @funcionarios = Funcionario.listaFuncionarios
    render 'funcionarios/index'
  end

  def update
    id = nil
    if params[:id] == "perfil"
      segurancaLogin(1)
      id = Pessoa.getPessoaLogada.id
    else
      segurancaLogin(11)
      id = params[:id]
    end
    @funcionario = Funcionario.find(id)
    funcionarioAux = Funcionario.new(funcionario_params)
    if funcionarioAux.cargo != nil && funcionarioAux.cargo.downcase == "gerente"
      @@resultadoPositivoFuncionario = "erro-O sistema já tem um gerente"
      carregar_tabela ''
      render 'funcionarios/index'
    elsif @funcionario.update(funcionario_params)
      if params[:id] == "perfil"
        @@resultadoPositivoFuncionario = "Perfil Atualizado";
        Pessoa.setPessoaLogada(@funcionario)
        redirect_to funcionarios_perfil_path
      else
        @@resultadoPositivoFuncionario = "Funcionário Atualizado";
        redirect_to funcionarios_path
      end
    else
      if params[:id] == "perfil"
        render 'funcionarios/perfil'
      else
        carregar_tabela('')
        render 'funcionarios/index'
      end

    end

  end

  def create
    segurancaLogin(11)
    @funcionario = Funcionario.new(funcionario_params)
    # tipo = 0 é cliente e. tipo = 1 é funcionario
    @funcionario.tipo = 1
    @funcionario.inativo = 0

    if @funcionario.cargo.downcase == "gerente"
      @@resultadoPositivoFuncionario = "erro-O sistema já tem um gerente"
      carregar_tabela ''
      render 'funcionarios/index'
    elsif @funcionario.save
      @@resultadoPositivoFuncionario = "Funcionário salvo"
      redirect_to
    else
      carregar_tabela('')
      render 'funcionarios/index'
    end

  end

  def destroy
    segurancaLogin(11)
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
    elsif pessoa == 11
    if Pessoa.getPessoaLogada() == nil || Pessoa.getPessoaLogada().tipo != 1 || Pessoa.getPessoaLogada().cargo != "gerente"
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
