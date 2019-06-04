class Contum < ApplicationRecord
  validates :cliente, presence: {message: "nao pode ser em branco"}
  validates :funcionario, presence: {message: "nao pode ser em branco"}
  validates :valor, presence: {message: "nao pode ser em branco"},
            numericality: {message: "deve ser um numero"}
  validates :juros, presence: {message: "nao pode ser em branco"},
            numericality: {message: "deve ser um numero"}

  scope :listaContasCliente, -> (query) { where("cliente like ?", "%#{query}%") }
  scope :listaContasFuncionario, -> (query) { where("funcionario like ?", "%#{query}%") }
  scope :listaContasDevendo, -> { where("status like ?", "%#{"devendo"}%") }
  scope :listaContasPagas, -> { where("status like ?", "%#{"paga"}%") }
  scope :listaContasAtrasadas, -> { where("status like ?", "%#{"atrasada"}%") }

end
