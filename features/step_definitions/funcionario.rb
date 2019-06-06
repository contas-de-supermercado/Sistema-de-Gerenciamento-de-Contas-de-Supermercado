Given("Eu abro a pagina inicial de funcionarios") do
  visit '/funcionarios'
end

Given("Eu vejo que o nao existe um funcionario com cpf {string}") do |cpf|
  page.has_no_content?(cpf)
end

When("Eu crio um funcionario com nome {string}, cpf {string}, celular {string}, cidade {string} ,rua {string}, numero,{string}, email {string}, senha {string}, cargo {string}") do |luis, cpf, celulcar,
    garanhus, farrapos, numeroCasa, email, senha, balconista|
  fill_in 'funcionario[nome]', :with => luis
  fill_in 'funcionario[cpf]', :with => cpf
  fill_in 'funcionario[celular]', :with => celulcar
  fill_in 'funcionario[cidade]', :with => garanhus
  fill_in 'funcionario[rua]', :with => farrapos
  fill_in 'funcionario[numero]', :with => numeroCasa
  fill_in 'funcionario[email]', :with => email
  fill_in 'funcionario[senha]', :with => senha
  fill_in 'funcionario[cargo]', :with => balconista
  click_button 'Adicionar'
end

Then("Eu vejo que o funcionario com cpf {string} esta visivel na pagina") do |cpf|
  page.has_content?(cpf)
end

Given("Eu vejo que o funcionario com cpf {string} ja existe") do |cpf|
  fill_in 'funcionario[nome]', :with => "Luis"
  fill_in 'funcionario[cpf]', :with => cpf
  fill_in 'funcionario[celular]', :with => "123456789"
  fill_in 'funcionario[cidade]', :with => "garanhus"
  fill_in 'funcionario[rua]', :with => "farrapos"
  fill_in 'funcionario[numero]', :with => "326"
  fill_in 'funcionario[email]', :with => "luis@gmail.com"
  fill_in 'funcionario[senha]', :with => "luis12345"
  fill_in 'funcionario[cargo]', :with => "balconista"
  click_button 'Adicionar'
  page.has_content?(cpf)
end

When("Eu seleciono editar o funcionario com cpf {string}") do |cpf|
  click_link "d-#{'edit-'+cpf}"
  page.has_content?(cpf)
end

Then("Eu vejo que apareceu uma mensagem de confirmacao que o funcionario foi editado") do
  page.has_content?(@id="resultadoPositivo")
end

When("Eu seleciono excluir o funcionario com cpf {string}") do |cpf|
  click_link "d-#{'delete-'+cpf}"
  page.has_no_content?(cpf)
end

Then("Eu vejo que o funcionario com cpf {string}, nao pode mais ser visto na pagina") do |cpf|
  page.has_no_content?(cpf)
end
