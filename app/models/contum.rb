class Contum < ApplicationRecord
  validates :cliente, presence: {message: "nao pode ser em branco"}
  validates :funcionario, presence: {message: "nao pode ser em branco"}
  validates :valor, presence: {message: "nao pode ser em branco"},
            numericality: {message: "deve ser um numero"},
            inclusion:{ in: 0..10000000000,message: "deve ser um numero positivo"}
  validates :juros, presence: {message: "nao pode ser em branco"},
            numericality: {message: "deve ser um numero"},
            length: { minimum: 1, too_short: "deve um numero positivo" },
            inclusion:{ in: 0..100,message: "deve ser um numero positivo entre 0 e 100"}

  def self.atualizarContas
    contas = listaContas
    time = Time.now
    contas.each do |conta|
      if time > conta.dataCompra
        conta.status = "Atrasada"
      end
    end
  end

  def self.listaContas
    contas = listaContasDevendo
    contas <= listasContasAtrasadas
    contas
  end
  scope :listaContasCliente, -> (query) { where("cliente like ?", "%#{query}%") }
  scope :listaContasFuncionario, -> (query) { where("funcionario like ?", "%#{query}%") }
  scope :listaContasDevendo, -> { where("status like ?", "%#{"devendo"}%") }
  scope :listaContasPagas, -> { where("status like ?", "%#{"paga"}%") }
  scope :listaContasAtrasadas, -> { where("status like ?", "%#{"atrasada"}%") }
  scope :listaContasData, -> (query) { where("dataCompra like ?", "%#{query}%") }
end
