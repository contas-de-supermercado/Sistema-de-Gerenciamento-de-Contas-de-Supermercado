Given("Eu abro a pagina inicial de contas") do
  visit '/contums/new'
end

Given("Eu preencho as informacoes de cliente com cpf {string} e do funcionario com cpf {string}") do |cpfCliente, cpfFuncionario|
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
  visit '/funcionarios'
  fill_in 'funcionario[nome]', :with => 'erik'
  fill_in 'funcionario[cpf]', :with => cpfFuncionario
  fill_in 'funcionario[celular]', :with => '987654321'
  fill_in 'funcionario[cidade]', :with => 'garanhus'
  fill_in 'funcionario[rua]', :with => 'farrapos'
  fill_in 'funcionario[numero]', :with => '0'
  fill_in 'funcionario[email]', :with => 'email2@gamil.com'
  fill_in 'funcionario[senha]', :with => 'senha3'
  fill_in 'funcionario[cargo]', :with => 'balconista'
  click_button 'Adicionar'
  visit '/contums/new'
  fill_in 'contum[cliente]', :with => cpfCliente
  fill_in 'contum[funcionario]', :with => cpfFuncionario
  #click_button "d-#{'cliente-'+cpfCliente}"
  #click_button "d-#{'funcionario-'+cpfFuncionario}"
end

When("Eu preencho valor da conta com {string}") do |valor|

  fill_in 'contum[valor]', :with => valor
  fill_in 'contum[juros]', :with => "3"
  click_button 'Adicionar'
end

Then("Eu vejo que a conta foi salva") do
  page.has_content?(@id="resultadoPositivo")
end

Given("Eu clico em editar") do
  visit '/clientes'
  fill_in 'cliente[nome]', :with => 'luis'
  fill_in 'cliente[cpf]', :with => "12345678910"
  fill_in 'cliente[celular]', :with => '123456789'
  fill_in 'cliente[cidade]', :with => 'garanhus'
  fill_in 'cliente[rua]', :with => 'farrapos'
  fill_in 'cliente[numero]', :with => '90'
  fill_in 'cliente[email]', :with => 'email@gmail.com'
  fill_in 'cliente[senha]', :with => 'senha2'
  click_button 'Adicionar'
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
  visit '/contums/new'
  fill_in 'contum[cliente]', :with => "12345678910"
  fill_in 'contum[funcionario]', :with => "11111111111"
  fill_in 'contum[valor]', :with => "100"
  fill_in 'contum[juros]', :with => "3"
  click_button 'Adicionar'
  click_link "d-#{'edit-'+Contum.last.id.to_s}"
  expect(page).to have_current_path(contums_path+'/'+Contum.last.id.to_s+'/edit')
end

When("Eu mudo o valor para {string}") do |valor|
  fill_in 'contum[valor]', :with => valor
  click_button 'Adicionar'
end

When("Eu excluo a conta") do
  visit '/clientes'
  fill_in 'cliente[nome]', :with => 'luis'
  fill_in 'cliente[cpf]', :with => "12345678910"
  fill_in 'cliente[celular]', :with => '123456789'
  fill_in 'cliente[cidade]', :with => 'garanhus'
  fill_in 'cliente[rua]', :with => 'farrapos'
  fill_in 'cliente[numero]', :with => '90'
  fill_in 'cliente[email]', :with => 'email@gmail.com'
  fill_in 'cliente[senha]', :with => 'senha2'
  click_button 'Adicionar'
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
  visit '/contums/new'
  fill_in 'contum[cliente]', :with => "12345678910"
  fill_in 'contum[funcionario]', :with => "11111111111"
  fill_in 'contum[valor]', :with => "100"
  fill_in 'contum[juros]', :with => "3"
  click_button 'Adicionar'
  click_link "d-#{'delete-'+Contum.last.id.to_s}"
end

Then("Eu vejo que a conta foi excluida com sucesso") do
  page.has_content?(@id="resultadoPositivo")
end

When("Eu nao preencho nehnum campo de contas") do
  fill_in 'contum[cliente]', :with => ""
  fill_in 'contum[funcionario]', :with => ""
  fill_in 'contum[valor]', :with => ""
  fill_in 'contum[juros]', :with => ""
  click_button 'Adicionar'
end

When("Eu preencho valor da conta com {string} negativo") do |valor|
  fill_in 'contum[valor]', :with => valor
  fill_in 'contum[juros]', :with => "3"
  click_button 'Adicionar'
end



