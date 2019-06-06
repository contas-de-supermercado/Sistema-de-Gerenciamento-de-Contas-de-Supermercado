class Funcionario < Pessoa
  validates :cargo, presence: {message: " nao pode ser em branco" }

  def self.pesquisa query
    funcionarios = listaFuncionarios;
    pesquisaIds = funcionarios.pesquisaId(query)
    pesquisaCpfs = funcionarios.pesquisaCpf(query)
    pesquisaNomes = funcionarios.pesquisaNome(query)
    resultado = []
    pesquisaIds.each do |funcionario|
      resultado << funcionario
    end
    pesquisaCpfs.each do |funcionario|
      if(!resultado.index(funcionario))
        resultado << funcionario
      end
    end
    pesquisaNomes.each do |funcionario|
      if(!resultado.index(funcionario))
        resultado << funcionario
      end
    end
    resultado
  end

  scope :listaFuncionarios, -> { where("tipo like ?", "%#{1}%") }
  scope :pesquisaId, ->(query) { where("id like ?", "%#{query}%") }
  scope :pesquisaCpf, ->(query) { where("cpf like ?", "%#{query}%") }
  scope :pesquisaNome, ->(query) { where("nome like ?", "%#{query}%") }
end