Feature: Gerenciar pagamento de contas
  As a Usuario do sistema de Gerenciamento financeiro de supermercado
  I want to fazer os pagamentos
  So that eu nao tenha que fazer isso manualmente

  Scenario: Pagar valor incompleto
    Given Eu abro a pagina de pagamento
    And Eu vejo que a conta do cliente com cpf "12345678910" existe
    And Eu seleciono o cliente com cpf "12345678910" que tera as contas pagas
    When Eu pago com valor menor do que o da conta
    Then Eu vejo uma mensagem que a conta ainda existe

  Scenario: Pagar valor completo
    Given Eu abro a pagina de pagamento
    And Eu vejo que a conta do cliente com cpf "12345678910" existe
    And Eu seleciono o cliente com cpf "12345678910" que tera as contas pagas
    When Eu pago o valor exato
    Then Eu vejo que o cliente nao deve mais

  Scenario: Efetuar pagamento sem conta selecionada
    Given Eu abro a pagina de pagamento
    And Eu vejo que a conta do cliente com cpf "12345678910" existe
    When Eu clico em pagar sem selecionar o cliente
    Then Eu vejo uma mensagem de erro na tela de pagamentos

  Scenario: Efetuar pagamento com valor invalido
    Given Eu abro a pagina de pagamento
    And Eu vejo que a conta do cliente com cpf "12345678910" existe
    And Eu seleciono o cliente com cpf "12345678910" que tera as contas pagas
    When Eu preencho o valor a ser pago com "reais"
    Then Eu vejo uma mensagem de erro na tela de pagamentos

  Scenario: Efetuar pagamento com valor nulo
    Given Eu abro a pagina de pagamento
    And Eu vejo que a conta do cliente com cpf "12345678910" existe
    And Eu seleciono o cliente com cpf "12345678910" que tera as contas pagas
    When Eu nao preencho o valor a ser pago
    Then Eu vejo uma mensagem de erro na tela de pagamentos
