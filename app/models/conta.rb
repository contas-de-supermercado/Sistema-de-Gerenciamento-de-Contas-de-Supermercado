class Conta < ApplicationRecord

  scope :listaContasCliente, -> (query) { where("cliente like ?", "%#{query}%") }
  scope :listaContasFuncionario, -> (query) { where("funcionario like ?", "%#{query}%") }
  scope :listaContasDevendo, -> { where("status like ?", "%#{"devendo"}%") }
  scope :listaContasPagas, -> { where("status like ?", "%#{"paga"}%") }
  scope :listaContasAtrasadas, -> { where("status like ?", "%#{"atrasada"}%") }

end
