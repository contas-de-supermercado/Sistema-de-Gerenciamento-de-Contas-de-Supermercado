class Pessoa < ApplicationRecord
  validates :nome, presence: {message: " nao pode ser em branco" },
            length: { minimum: 3, too_short: "deve ter pelo menos 3 caracteres" }
  validates :cpf, presence: {message: " nao pode ser em branco" },
            length: { is: 11 , message: "deve ter 11 caracteres"},
            uniqueness: {message: " nao pode ser repetido" },
            numericality: {message: "deve ser um numero"}
  validates :senha, presence: {message: " nao pode ser em branco" },
            length: {minimum: 5,too_short: "deve ter pelo menos 5 caracteres" }
  validates :email, presence: {message: " nao pode ser em branco" },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "so permite emails validos" },
            uniqueness: {message: " nao pode ser repetido" }
  validates :cidade, presence: {message: " nao pode ser em branco" }
  validates :rua, presence: {message: " nao pode ser em branco" }
  validates :numero, presence: {message: " nao pode ser em branco" }
  validates :celular, presence: {message: " nao pode ser em branco" },
            length: { in: 9..11 , message: " numero com tamanho incorreto"},
            numericality: {message: "deve ser um numero"}

  @@pessoaLogada = nil

  def self.getPessoaLogada
    @@pessoaLogada
  end
  def self.setPessoaLogada pessoa
    @@pessoaLogada = pessoa
  end

  def self.login email, senha
    if email == "funcionario" && senha == "funcionario"
      Pessoa.setPessoaLogada(Pessoa.new nome:"admin", cpf:"00000000000", telefone:"00000000000", celular:"00000000000",
                                        email:"admin@gmail.com", senha:"admin", cidade:"-----", rua:"-----", numero:"-----", cargo:"-----",
                                        tipo:1)
    elsif email == "cliente" && senha == "cliente"
      Pessoa.setPessoaLogada(Pessoa.new nome:"admin", cpf:"00000000000", telefone:"00000000000", celular:"00000000000",
                                        email:"admin@gmail.com", senha:"admin", cidade:"-----", rua:"-----", numero:"-----", cargo:"-----",
                                        tipo:0)
    else
    pessoas = Cliente.listaClientes
    resultado = nil
    pessoas.each do |pessoa|
      if (pessoa.cpf == email || pessoa.email == email) && (pessoa.senha == senha)
        resultado = pessoa
        break
      end
    end
    resultado
    end
  end

end
