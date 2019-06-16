require 'cucumber/rails'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'rspec/expectations'

module Login
  def logarComoFuncionario
    Pessoa.setPessoaLogada(Pessoa.new nome:"teste", cpf:"00000000000", telefone:"00000000000", celular:"00000000000",
                                      email:"teste@gmail.com", senha:"teste", cidade:"-----", rua:"-----", numero:"-----", cargo:"-----",
                                      tipo:1)
  end

  def logarComoCliente
    Pessoa.setPessoaLogada(Pessoa.new nome:"teste", cpf:"00000000000", telefone:"00000000000", celular:"00000000000",
                                      email:"teste@gmail.com", senha:"teste", cidade:"-----", rua:"-----", numero:"-----", cargo:"-----",
                                      tipo:0)
  end
end
