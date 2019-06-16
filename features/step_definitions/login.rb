Given("Eu abro a pagina inicial do sistema") do
  visit '/logins'
end

Given("O usuario existe") do
  visit '/funcionarios'
  fill_in 'funcionario[nome]', :with => "Luis"
  fill_in 'funcionario[cpf]', :with => "11111111111"
  fill_in 'funcionario[celular]', :with => "123456789"
  fill_in 'funcionario[cidade]', :with => "garanhus"
  fill_in 'funcionario[rua]', :with => "farrapos"
  fill_in 'funcionario[numero]', :with => "326"
  fill_in 'funcionario[email]', :with => "luis@gmail.com"
  fill_in 'funcionario[senha]', :with => "luis12345"
  fill_in 'funcionario[cargo]', :with => "balconista"
  click_button 'Adicionar'
  visit '/logins'
end

When("Eu preencho o campo senha com {string}") do |senha|
  fill_in 'emailLogin', :with => "11111111111"
  fill_in 'senhaLogin', :with => senha
end

Then("Eu vejo uma mensagem de erro na tela de login") do
  page.has_content?(@id="resultadoNegativo>")
end

When("Eu preencho o campo CPf com {string}") do |cpf|
  fill_in 'emailLogin', :with => cpf
  fill_in 'senhaLogin', :with => "luis12345"
end

Given("O funcionario CPf com {string} e a senha com {string} existe") do |cpf, senha|
  logarComoFuncionario()
  visit '/funcionarios'
  fill_in 'funcionario[nome]', :with => "Luis"
  fill_in 'funcionario[cpf]', :with => cpf
  fill_in 'funcionario[celular]', :with => senha
  fill_in 'funcionario[cidade]', :with => "garanhus"
  fill_in 'funcionario[rua]', :with => "farrapos"
  fill_in 'funcionario[numero]', :with => "326"
  fill_in 'funcionario[email]', :with => "luis@gmail.com"
  fill_in 'funcionario[senha]', :with => "luis12345"
  fill_in 'funcionario[cargo]', :with => "balconista"
  click_button 'Adicionar'
  visit '/logins'
end

When("Eu preencho o campo CPf com {string} e a senha com {string}") do |cpf, senha|
  fill_in 'emailLogin', :with => cpf
  fill_in 'senhaLogin', :with => senha
end

Then("Eu logo como funcionario") do
  click_button 'Logar'
  page.has_content?('Registrar uma conta de cliente')
end

When("Eu nao preencho o campo senha") do
  fill_in 'emailLogin', :with => "11111111111"
  fill_in 'senhaLogin', :with => ''
end

When("Eu nao preencho o campo CPF do login") do
  fill_in 'emailLogin', :with => ''
  fill_in 'senhaLogin', :with => "luis12345"

end

