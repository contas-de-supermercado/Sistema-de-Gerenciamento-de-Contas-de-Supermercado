Given("Eu abro a pagina de pagamento") do
  visit '/pagamentos'
end

Given("Eu vejo que a conta do cliente com cpf {string} existe") do |cpfCliente|
  visit '/funcionarios'
  fill_in 'funcionario[nome]', :with => 'erik'
  fill_in 'funcionario[cpf]', :with => "11111111111"
  fill_in 'funcionario[celular]', :with => '987654321'
  fill_in 'funcionario[cidade]', :with => 'garanhus'
  fill_in 'funcionario[rua]', :with => 'farrapos'
  fill_in 'funcionario[numero]', :with => '0'
  fill_in 'funcionario[email]', :with => 'email2@gamil.com'
  fill_in 'funcionario[senha]', :with => 'senha3'
  fill_in 'funcionario[cargo]', :with => 'balconista'
  click_button 'Adicionar'
  visit '/clientes'
  fill_in 'cliente[nome]', :with => 'luis'
  fill_in 'cliente[cpf]', :with => cpfCliente
  fill_in 'cliente[celular]', :with => '123456789'
  fill_in 'cliente[cidade]', :with => 'garanhus'
  fill_in 'cliente[rua]', :with => 'farrapos'
  fill_in 'cliente[numero]', :with => '90'
  fill_in 'cliente[email]', :with => 'email@gmail.com'
  fill_in 'cliente[senha]', :with => 'senha2'
  click_button 'Adicionar'
  visit '/contums/new'
  fill_in 'contum[cliente]', :with => "12345678910"
  fill_in 'contum[funcionario]', :with => "11111111111"
  fill_in 'contum[valor]', :with => "100"
  fill_in 'contum[juros]', :with => "3"
  click_button 'Adicionar'
  visit '/pagamentos'
end

Given("Eu seleciono o cliente com cpf {string} que tera as contas pagas") do |cpfCliente|
  click_link "d-#{'pagar-'+cpfCliente}"
end

When("Eu pago com valor menor do que o da conta") do
  fill_in 'valorCliente', :with => "3"
  click_button @id="botaoPagar"
end

Then("Eu vejo uma mensagem que a conta ainda existe") do
  page.has_content?(@id="resultadoRestante")
end

When("Eu pago o valor exato") do
  fill_in 'valorCliente', :with => "100"
  click_button @id="botaoPagar"
end

Then("Eu vejo que o cliente nao deve mais") do
  page.has_content?(@id="resultadoPositivo")
end

When("Eu clico em pagar sem selecionar o cliente") do
  visit '/pagamentos'
  click_button @id="botaoPagar"
end

When("Eu preencho o valor a ser pago com {string}") do |reais|
  fill_in 'valorCliente', :with => reais
  click_button @id="botaoPagar"
end

Then("Eu vejo uma mensagem de erro na tela de pagamentos") do
  page.has_content?(@id="resultadoNegativo")
end

When("Eu nao preencho o valor a ser pago") do
  fill_in 'valorCliente', :with => ''
  click_button @id="botaoPagar"
end

