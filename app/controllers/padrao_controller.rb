class PadraoController < ApplicationController

  def contato
    segurancaLogin
  end

  private
  def segurancaLogin
    if Pessoa.getPessoaLogada() == nil
      redirect_to logins_path
    end
  end
end