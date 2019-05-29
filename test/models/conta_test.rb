require 'test_helper'

class ContaTest < ActiveSupport::TestCase


  test 'Deve salvar conta com um cliente, um funcionario e um valor' do

    cliente = Cliente.new nome: 'felipe', cpf:'11304353427', celular:'999999999', email:'felipe@gmail.com', senha:'12345',
                          cidade:'garanhuns', rua:'centro', numero:'0'

    funcionario = Funcionario.new nome: 'jose', cpf:'11111111111', celular:'999999999', email:'jose@gmail.com',
                                  senha:'123456789', cidade:'garanhuns', rua:'centro', numero:'0', cargo:'caixa'

    conta = Conta.new cliente: cliente.id, funcionario: funcionario.id, valor:100

    assert conta.save
  end

end
