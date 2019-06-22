module Login
  def logarComoFuncionario
    Pessoa.setPessoaLogada(Pessoa.new nome:"teste", cpf:"00000000000", telefone:"00000000000", celular:"00000000000",
                                      email:"teste@gmail.com", senha:"teste", cidade:"-----", rua:"-----", numero:"-----", cargo:"gerente",
                                      tipo:1)
  end

  def logarComoCliente
    Pessoa.setPessoaLogada(Pessoa.new nome:"teste", cpf:"00000000000", telefone:"00000000000", celular:"00000000000",
                                      email:"teste@gmail.com", senha:"teste", cidade:"-----", rua:"-----", numero:"-----", cargo:"-----",
                                      tipo:0)
  end
end

World Login

Given("Eu abro a pagina inicial de clientes") do
  logarComoFuncionario()
  visit '/clientes'
end
Given("Eu vejo que o nao existe um cliente com cpf {string}") do |cpf|
  page.has_no_content?(cpf)
end

When("Eu crio um cliente com nome {string}, cpf {string}, celular {string}, cidade {string} ,rua {string}, numero,{string}, email {string}, senha {string}") do |luis, cpf, celulcar,
    garanhus, farrapos, numeroCasa, email, senha|
  fill_in 'cliente[nome]', :with => luis
  fill_in 'cliente[cpf]', :with => cpf
  fill_in 'cliente[celular]', :with => celulcar
  fill_in 'cliente[cidade]', :with => garanhus
  fill_in 'cliente[rua]', :with => farrapos
  fill_in 'cliente[numero]', :with => numeroCasa
  fill_in 'cliente[email]', :with => email
  fill_in 'cliente[senha]', :with => senha
  click_button 'Adicionar'
end

Then("Eu vejo que o cliente com cpf {string} esta visivel na pagina") do |cpf|
  page.has_content?(cpf)
end

Given("Eu vejo que o cliente com cpf {string} ja existe") do |cpf|
  fill_in 'cliente[nome]', :with => "Luis"
  fill_in 'cliente[cpf]', :with => cpf
  fill_in 'cliente[celular]', :with => "123456789"
  fill_in 'cliente[cidade]', :with => "garanhus"
  fill_in 'cliente[rua]', :with => "farrapos"
  fill_in 'cliente[numero]', :with => "326"
  fill_in 'cliente[email]', :with => "luis@gmail.com"
  fill_in 'cliente[senha]', :with => "luis12345"
  click_button 'Adicionar'
  page.has_content?(cpf)
end

When("Eu seleciono editar o cliente com cpf {string}") do |cpf|
  click_link "d-#{'edit-'+cpf}"
  page.has_content?(cpf)
end

When("eu mudo o numero de celular do cliente para {string}") do |numero|
  fill_in 'cliente[celular]', :with => numero
  click_button 'Adicionar'
end
When("eu mudo o numero de celular do funcionario para {string}") do |numero|
  fill_in 'funcionario[celular]', :with => numero
  click_button 'Adicionar'
end

Then("Eu vejo que apareceu uma mensagem de confirmacao que o cliente foi editado") do
  page.has_content?(@id="resultadoPositivo")
end

When("Eu seleciono excluir o cliente com cpf {string}") do |cpf|
  click_link "d-#{'delete-'+cpf}"
  page.has_no_content?(cpf)
end

Then("Eu vejo que o cliente com cpf {string}, nao pode mais ser visto na pagina") do |cpf|
  page.has_no_content?(cpf)
end

When("Eu nao preencho o campo nome") do
  fill_in 'cliente[nome]', :with => ''
  fill_in 'cliente[cpf]', :with => "12345678910"
  fill_in 'cliente[celular]', :with => "123456789"
  fill_in 'cliente[cidade]', :with => "garanhus"
  fill_in 'cliente[rua]', :with => "farrapos"
  fill_in 'cliente[numero]', :with => "326"
  fill_in 'cliente[email]', :with => "luis@gmail.com"
  fill_in 'cliente[senha]', :with => "luis12345"
end

When("Clico em adicionar") do
  click_button 'Adicionar'
end

Then("Eu vejo uma mensagem de erro na tela") do
  page.has_no_content?('Dados invalidos')
end

When("Eu nao preencho o campo CPF") do
  fill_in 'cliente[nome]', :with => "luis"
  fill_in 'cliente[cpf]', :with => ''
  fill_in 'cliente[celular]', :with => "123456789"
  fill_in 'cliente[cidade]', :with => "garanhus"
  fill_in 'cliente[rua]', :with => "farrapos"
  fill_in 'cliente[numero]', :with => "326"
  fill_in 'cliente[email]', :with => "luis@gmail.com"
  fill_in 'cliente[senha]', :with => "luis12345"
end