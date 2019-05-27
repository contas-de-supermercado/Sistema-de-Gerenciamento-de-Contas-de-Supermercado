class ContaController < ApplicationController
  def index
    @contas = Conta.all
  end
  def new
    @conta = Conta.new
  end
  def edit
    @conta = Conta.find(params[:id])
    @contas = Conta.all
    render 'conta/index'
  end
  def update
    @conta = Conta.find(params[:id])
    @conta.update(conta_params)
    redirect_to conta_path
  end
  def create
    @conta = Conta.new
    @conta.save
    redirect_to
  end
  def destroy
    @conta = Conta.find(params[:id])
    @conta.destroy
    redirect_to conta_path
  end
  private
  def conta_params
    params.require(:conta).permit(:status, :valor, :data_compra, :data_pagamento, :funcionario, :juros)
  end
end
