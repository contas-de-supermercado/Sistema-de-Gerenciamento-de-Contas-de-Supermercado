class Pessoa < ApplicationRecord
  validates :nome, presence: {message: " nao pode ser em branco" },
            length: { minimum: 3, too_short: "deve ter pelo menos 3 caracteres" }
  validates :cpf, presence: {message: " nao pode ser em branco" },
            length: { is: 11 , message: "deve ter 11 caracteres"},
            uniqueness: {message: " nao pode ser repetido" }
  validates :senha, presence: {message: " nao pode ser em branco" },
            length: {minimum: 5,too_short: "deve ter pelo menos 5 caracteres" }
  validates :email, presence: {message: " nao pode ser em branco" },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "so permite emails validos" },
            uniqueness: {message: " nao pode ser repetido" }
  validates :cidade, presence: {message: " nao pode ser em branco" }
  validates :rua, presence: {message: " nao pode ser em branco" }
  validates :numero, presence: {message: " nao pode ser em branco" }
  validates :celular, presence: {message: " nao pode ser em branco" },
            length: { in: 9..11 , message: " numero com tamanho incorreto"}

end
