require 'test_helper'

class ContaTest < ActiveSupport::TestCase

  # test "the truth" do
  #   assert true
  # end

  test 'Deve salvar conta com um cliente, um funcionario e um valor' do
    cliente = Cliente.new nome:'luis', cpf:'11304353427', celular:'999999999', email:'felipe@gmail.com', senha:'12345', cidade:'garanhuns', rua:'centro', numero:'0'
    cliente.save
    funcionario = Funcionario.new nome: 'jose', cpf:'11111111111', celular:'999999999', email:'jose@gmail.com', senha:'123456789', cidade:'garanhuns', rua:'centro', numero:'0', cargo:'caixa'
    funcionario.save
    conta = Contum.new cliente: cliente.id, funcionario: funcionario.id, valor:100, juros: 2
    assert conta.save
  end

end
