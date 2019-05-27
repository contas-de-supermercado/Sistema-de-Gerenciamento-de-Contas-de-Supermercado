class FicheiroController < ApplicationController
  def index
    @ficheiros = Ficheiro.all
  end
  def new
    @ficheiro = Ficheiro.new
  end
  def edit
    @ficheiro = Ficheiro.find(params[:id])
    @ficheiros = Ficheiro.all
  end
  def update
    @ficheiro = Ficheiro.find(params[:id])
    @ficheiros = Ficheiro.all
    redirect_to ficheiro_path
  end
  def create
    @ficheiro = Ficheiro.new(feicheiro_params)
    redirect_to
  end
  def destroy
    @ficheiro = Ficheiro.find(params[:id])
    @ficheiro.destroy
    redirect_to ficheiro_path
  end
  private
  def ficheiro_params
    params.require(:ficheiro).permit(:contas_devendo,:contas_pagas,:contas_atrasadas)
  end
end
