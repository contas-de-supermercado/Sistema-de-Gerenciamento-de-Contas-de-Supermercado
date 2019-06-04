require "time"

class FicheirosController < ApplicationController

  @@resultadoPositivoFicheiro = ""

  def self.getResultadoPositivoFicheiro
    @@resultadoPositivoFicheiro
  end
  def self.setResultadoPositivoFicheiro valor
    @@resultadoPositivoFicheiro  = valor
  end

  def index
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

  def new
    @conta = Conta.new
  end

  def create
    @conta = Conta.new(ficheiro_params)
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
        @@resultadoPositivoFicheiro = "Conta salva"
        if !@conta.juros
          @conta.juros = 0
        end
        if !@conta.valor
          @conta.valor = 0
        end
        @conta.save
      end
    end

    redirect_to
  end

  private
  def ficheiro_params
    params.require(:ficheiro).permit(:cliente, :funcionario, :valor, :juros, :status, :comprador, :parentesco)
  end

end
