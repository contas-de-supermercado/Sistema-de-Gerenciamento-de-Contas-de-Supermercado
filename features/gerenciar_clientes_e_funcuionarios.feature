Feature: Gerenciar clientes e funcionarios
  As a Usuario do sistema de Gerenciamento financeiro de supermercado
  I want to adicionar, remover, ver e editar um cliente e adicionar, remover, ver e editar um funcionario
  So that eu nao tenha que fazer isso manualmente

  Scenario: Adicionar um cliente
    Given Eu abro a pagina inicial de clientes
    And Eu vejo que o nao existe um cliente com cpf "12345678901"
    When Eu crio um cliente com nome "Luis", cpf "12345678901", celular "123456789", cidade "Garanhus" ,rua "Farrapos", numero,"326", email "luis@gmail.com", senha "luis12345"
    Then Eu vejo que o cliente com cpf "12345678901" esta visivel na pagina

  Scenario: Editar um cliente
    Given Eu abro a pagina inicial de clientes
    And Eu vejo que o cliente com cpf "12345678910" ja existe
    When Eu seleciono editar o cliente com cpf "12345678910"
    And eu mudo o numero de celular do cliente para "999999999"
    Then Eu vejo que apareceu uma mensagem de confirmacao que o cliente foi editado

  Scenario:Remover cliente
    Given Eu abro a pagina inicial de clientes
    And Eu vejo que o cliente com cpf "12345678910" ja existe
    When Eu seleciono excluir o cliente com cpf "12345678910"
    Then Eu vejo que o cliente com cpf "12345678910", nao pode mais ser visto na pagina

  Scenario: Criar cliente sem nome
    Given Eu abro a pagina inicial de clientes
    And Eu vejo que o nao existe um cliente com cpf "12345678901"
    When  Eu nao preencho o campo nome
    And Clico em adicionar
    Then Eu vejo uma mensagem de erro na tela

  Scenario: Criar cliente sem CPF
    Given Eu abro a pagina inicial de clientes
    And Eu vejo que o nao existe um cliente com cpf "12345678901"
    When Eu nao preencho o campo CPF
    And Clico em adicionar
    Then Eu vejo uma mensagem de erro na tela

  Scenario: Adicionar um funcionario
    Given Eu abro a pagina inicial de funcionarios
    And Eu vejo que o nao existe um funcionario com cpf "12345678901"
    When Eu crio um funcionario com nome "Luis", cpf "12345678901", celular "123456789", cidade "Garanhus" ,rua "Farrapos", numero,"326", email "luis@gmail.com", senha "luis12345", cargo "balconista"
    Then Eu vejo que o funcionario com cpf "12345678901" esta visivel na pagina

  Scenario: Editar um funcionario
    Given Eu abro a pagina inicial de funcionarios
    And Eu vejo que o funcionario com cpf "12345678910" ja existe
    When Eu seleciono editar o funcionario com cpf "12345678910"
    And eu mudo o numero de celular do funcionario para "999999999"
    Then Eu vejo que apareceu uma mensagem de confirmacao que o funcionario foi editado

  Scenario:Remover um funcionario
    Given Eu abro a pagina inicial de funcionarios
    And Eu vejo que o funcionario com cpf "12345678910" ja existe
    When Eu seleciono excluir o funcionario com cpf "12345678910"
    Then Eu vejo que o funcionario com cpf "12345678910", nao pode mais ser visto na pagina