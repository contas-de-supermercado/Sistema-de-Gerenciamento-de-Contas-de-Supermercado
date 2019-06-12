require 'test_helper'

class FuncionarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'criar funcionario' do
    funcionario = Funcionario.new nome:'Luis', cpf:'12345678910', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789', cargo:'balconista'
    assert funcionario.save
  end
  test 'criar funcionario com nome invalido' do
    funcionario = Funcionario.new nome:'Ai', cpf:'12345678910', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789',cargo:'balconisra'
    assert_not funcionario.save
  end
  test 'criar funcionario sem nome e sem cpf' do
    funcionario = Funcionario.new nome:'', cpf:'', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789',cargo:'balconista'
    assert_not funcionario.save
  end
  test 'criar funcionario com tamanho de cpf invalido' do
    funcionario = Funcionario.new nome:'Luis', cpf:'12345', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789',cargo:'balconista'
    assert_not funcionario.save
  end
  test 'criar funcionario sem algum cargo especifico' do
    funcionario = Funcionario.new nome:'Luis', cpf:'12345678910', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789',cargo:''
    assert_not funcionario.save
  end
  test 'criar funcionario com cpf contendo algum letra' do
    funcionario = Funcionario.new nome:'Luis', cpf:'12345abcdef', senha:'12345', email:'luis@gmail.com', cidade:'garanhus', rua:'Farrapos', numero:'326', celular:'123456789', cargo:'balconista'
    assert_not funcionario.save
  end
end

