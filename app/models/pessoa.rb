class Pessoa < ApplicationRecord
  validates_with ValidacoesAuxPessoa
  validates :nome, presence: {message: " nao pode ser em branco" },
            length: { minimum: 3, too_short: "deve ter pelo menos 3 caracteres" }
  validates :cpf, presence: {message: " nao pode ser em branco" },
            length: { is: 11 , message: "deve ter 11 caracteres"},
            numericality: {message: "deve ser um numero"}
  validates :senha, presence: {message: " nao pode ser em branco" },
            length: {minimum: 5,too_short: "deve ter pelo menos 5 caracteres" }
  validates :email, presence: {message: " nao pode ser em branco" },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "so permite emails validos" }
  validates :cidade, presence: {message: " nao pode ser em branco" }
  validates :rua, presence: {message: " nao pode ser em branco" }
  validates :numero, presence: {message: " nao pode ser em branco" }
  validates :celular, presence: {message: " nao pode ser em branco" },
            length: { in: 9..11 , message: " numero com tamanho incorreto"},
            numericality: {message: "deve ser um numero"}

  def self.verificarExisteCpfAtivo pessoa
    pessoas = Cliente.listaClientes
    pessoas.each do |pessoaAux|
      if pessoaAux.cpf == pessoa.cpf && pessoaAux.id != pessoa.id
        return pessoa
      end
    end
    return nil
  end

  def self.verificarExisteEmailAtivo pessoa
    pessoas = Cliente.listaClientes
    pessoas.each do |pessoaAux|
      if pessoaAux.email == pessoa.email && pessoaAux.id != pessoa.id
        return pessoa
      end
    end
    return nil
  end

  @@pessoaLogada = nil

  def self.getPessoaLogada
    @@pessoaLogada
  end
  def self.setPessoaLogada pessoa
    @@pessoaLogada = pessoa
  end

  def self.login email, senha
    pessoas = Pessoa.all
    resultado = nil
    pessoas.each do |pessoa|
      if pessoa.inativo == 0 && (pessoa.cpf == email || pessoa.email == email) && (pessoa.senha == senha)
        resultado = pessoa
        break
      end
    end
    resultado
  end

  def self.verificarCadastroGerente
    resultado = false
    funcionarios = Funcionario.listaFuncionariosAtivo
    funcionarios.each do |funcionario|
      if funcionario.cargo == "gerente"
        resultado = true
        break
      end
    end

    if resultado == false
      funcionario = Pessoa.new nome:"admin", cpf:"99999999999", telefone:"00000000000", celular:"00000000000",
                               email:"admin@gmail.com", senha:"admin", cidade:"-----", rua:"-----", numero:"-----", cargo:"gerente",
                               tipo:1, inativo: 0
      funcionario.save
    end
  end

end
