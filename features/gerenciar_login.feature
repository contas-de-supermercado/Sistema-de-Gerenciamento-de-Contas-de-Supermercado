Feature: Gerenciar login de cliente e de funcionario
  As a cliente ou funcionario do sistema de Gerenciamento financeiro de supermercado
  I want to logar no sistema
  So that eu possa ter acesso as funcionalidades do sistema

  Scenario: Senha invalida
    Given Eu abro a pagina inicial do sistema
    And O usuario existe
    When Eu preencho o campo senha com "123"
    Then Eu vejo uma mensagem de erro na tela de login

  Scenario: Cpf invalida
    Given Eu abro a pagina inicial do sistema
    And O usuario existe
    When Eu preencho o campo CPf com "2345"
    Then Eu vejo uma mensagem de erro na tela de login

  Scenario: Logar
    Given Eu abro a pagina inicial do sistema
    And O funcionario CPf com "12345678910" e a senha com "123qwe" existe
    When Eu preencho o campo CPf com "12345678910" e a senha com "123qwe"
    Then Eu logo como funcionario

  Scenario: Senha vazia
    Given Eu abro a pagina inicial do sistema
    And O usuario existe
    When Eu nao preencho o campo senha
    Then Eu vejo uma mensagem de erro na tela de login

  Scenario: Cpf vazio
    Given Eu abro a pagina inicial do sistema
    And O usuario existe
    When Eu nao preencho o campo CPF do login
    Then Eu vejo uma mensagem de erro na tela de login