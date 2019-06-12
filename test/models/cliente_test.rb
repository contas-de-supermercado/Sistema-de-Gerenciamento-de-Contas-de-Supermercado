require 'test_helper'

class ClienteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'criar cliente' do
    cliente = Cliente.new nome:'Luis', cpf:'12345678910', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789'
    assert cliente.save
  end
  test 'criar cliente com nome invalido' do
    cliente = Cliente.new nome:'Ai', cpf:'12345678910', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789'
    assert_not cliente.save
  end
  test 'criar cliente sem nome e sem cpf' do
    cliente = Cliente.new nome:'', cpf:'', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789'
    assert_not cliente.save
  end
  test 'criar cliente com tamanho de cpf invalido' do
    cliente = Cliente.new nome:'Luis', cpf:'12345',senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789'
    assert_not cliente.save
  end
  test 'criar cliente com cpf contendo algum letra' do
    cliente = Cliente.new nome:'Luis', cpf:'12345abcdef',senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789'
    assert_not cliente.save
  end
  test 'criar cliente sem senha' do
    cliente = Cliente.new nome:'Luis', cpf:'12345678910', senha:'', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789'
    assert_not cliente.save
  end
end

