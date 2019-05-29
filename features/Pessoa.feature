Feature: Gerenciamento de artigos
  As a Usuario do sistema blog
  I want to Adicionar, remover e editar um artigo
  so that Para mim evitar de fazer isso manualmente

  Scenario: Adicionar um artigo ao blog
    Given Eu abro a pagina de criar um novo artigo
    When Eu crio um novo artigo com o texto 'novo artigo' e com o titulo 'artigo novo'
    Then Eu vejo que o artigo com o titulo 'artigo novo' foi salvo