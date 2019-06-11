Feature: Gerenciar pagamento de contas
  As a Usuario do sistema de Gerenciamento financeiro de supermercado
  I want to fazer os pagamentos
  So that eu nao tenha que fazer isso manualmente

  #Scenario: Pagar valor incompleto
    #Given Eu abro a pagina de contas
    #And Eu seleciono a conta a ser paga
    #When Eu altero para uma valor ja existente para um menor
    #Then Eu vejo que a conta ainda existe

  #Scenario: Pagar valor completo
    #Given Eu abro a pagina de contas
    #And Eu seleciono a conta a ser paga
    #When Eu quito a conta
    #Then Eu vejo que o cliente nao deve mais a conta

  #Scenario: Efetuar pagamento sem conta selecionada
    #Given Given Eu abro a pagina de contas
    #And Eu nao seleciono a conta a ser paga
    #When Eu clico em pagar
    #Then Eu vejo uma mensagem de erro na tela

  #Scenario: Efetuar pagamento com valor invalido
    #Given Eu abro a pagina de contas
    #And Eu seleciono a conta a ser paga
    #When Eu preencho o valor a ser pago com "reais"
    #Then Eu vejo uma mensagem de erro na tela

  #Scenario: Efetuar pagamento com valor invalido
    #Given Eu abro a pagina de contas
    #And Eu seleciono a conta a ser paga
    #When Eu preencho o valor a ser pago com ""
    #Then Eu vejo uma mensagem de erro na tela
