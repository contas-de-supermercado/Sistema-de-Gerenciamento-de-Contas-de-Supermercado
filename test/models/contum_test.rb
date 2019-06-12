require 'test_helper'

class ContaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Criar conta' do
    cliente = Cliente.new nome:'luis', cpf:'11304353427', celular:'999999999', email:'felipe@gmail.com', senha:'12345', cidade:'garanhuns', rua:'centro', numero:'0'
    cliente.save
    funcionario = Funcionario.new nome: 'jose', cpf:'11111111111', celular:'999999999', email:'jose@gmail.com', senha:'123456789', cidade:'garanhuns', rua:'centro', numero:'0', cargo:'caixa'
    funcionario.save
    conta = Contum.new cliente: cliente.id, funcionario: funcionario.id, valor:100, juros: 2
    assert conta.save
  end

  test 'Criar conta sem funcionario' do
    cliente = Cliente.new nome:'luis', cpf:'11304353427', celular:'999999999', email:'felipe@gmail.com', senha:'12345', cidade:'garanhuns', rua:'centro', numero:'0'
    cliente.save
    conta = Contum.new cliente: cliente.id, valor:100, juros: 2
    assert_not conta.save
  end

  test 'Criar conta sem cliente' do
    funcionario = Funcionario.new nome: 'jose', cpf:'11111111111', celular:'999999999', email:'jose@gmail.com', senha:'123456789', cidade:'garanhuns', rua:'centro', numero:'0', cargo:'caixa'
    funcionario.save
    conta = Contum.new funcionario: funcionario.id, valor:100, juros: 2
    assert_not conta.save
  end

  test 'Criar conta com valor conta negativo' do
    cliente = Cliente.new nome:'luis', cpf:'11304353427', celular:'999999999', email:'felipe@gmail.com', senha:'12345', cidade:'garanhuns', rua:'centro', numero:'0'
    cliente.save
    funcionario = Funcionario.new nome: 'jose', cpf:'11111111111', celular:'999999999', email:'jose@gmail.com', senha:'123456789', cidade:'garanhuns', rua:'centro', numero:'0', cargo:'caixa'
    funcionario.save
    conta = Contum.new cliente: cliente.id, funcionario: funcionario.id, valor:-100, juros: 2
    assert_not conta.save
  end

  test 'Criar conta sem juros' do
    cliente = Cliente.new nome:'luis', cpf:'11304353427', celular:'999999999', email:'felipe@gmail.com', senha:'12345', cidade:'garanhuns', rua:'centro', numero:'0'
    cliente.save
    funcionario = Funcionario.new nome: 'jose', cpf:'11111111111', celular:'999999999', email:'jose@gmail.com', senha:'123456789', cidade:'garanhuns', rua:'centro', numero:'0', cargo:'caixa'
    funcionario.save
    conta = Contum.new cliente: cliente.id, funcionario: funcionario.id, valor:100
    assert_not conta.save
  end

  test 'Criar conta sem valor de conta' do
    cliente = Cliente.new nome:'luis', cpf:'11304353427', celular:'999999999', email:'felipe@gmail.com', senha:'12345', cidade:'garanhuns', rua:'centro', numero:'0'
    cliente.save
    funcionario = Funcionario.new nome: 'jose', cpf:'11111111111', celular:'999999999', email:'jose@gmail.com', senha:'123456789', cidade:'garanhuns', rua:'centro', numero:'0', cargo:'caixa'
    funcionario.save
    conta = Contum.new cliente: cliente.id, funcionario: funcionario.id, juros: 2
    assert_not conta.save
  end
end
