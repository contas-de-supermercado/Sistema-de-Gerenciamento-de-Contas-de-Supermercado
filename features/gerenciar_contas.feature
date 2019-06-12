Feature: Gerenciamento de contas
  As a Usuário do sistema de Gerenciamento financeiro de supermercado
  I want to adicionar, remover, ver e editar uma conta
  So that eu nao tenha que fazer isso manualmente

  Scenario: Criar conta
    Given Eu abro a pagina inicial de contas
    And Eu preencho as informacoes de cliente com cpf "12345678910" e do funcionario com cpf "11111111111"
    When Eu preencho valor da conta com "20.20"
    Then Eu vejo que a conta foi salva

  Scenario: Editar valor da conta
    Given Eu abro a pagina inicial de contas
    And Eu clico em editar
    When Eu mudo o valor para "30.30"
    Then Eu vejo que a conta foi salva

  Scenario: Excluir conta
    Given Eu abro a pagina inicial de contas
    When Eu excluo a conta
    Then Eu vejo que a conta foi excluida com sucesso

  Scenario: Criar conta com valor negativo
    Given Eu abro a pagina inicial de contas
    When Eu preencho valor da conta com "-20.20" negativo
    Then Eu vejo uma mensagem de erro na tela

  Scenario: Criar conta com valor em branco
    Given Eu abro a pagina inicial de contas
    When Eu nao preencho nehnum campo de contas
    Then Eu vejo uma mensagem de erro na tela
