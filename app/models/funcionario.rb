class Funcionario < Pessoa

  def self.pesquisa query
    funcionarios = listaFuncionarios(1);
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

  scope :listaFuncionarios, ->(query) { where("tipo like ?", "%#{query}%") }
  scope :pesquisaId, ->(query) { where("id like ?", "%#{query}%") }
  scope :pesquisaCpf, ->(query) { where("cpf like ?", "%#{query}%") }
  scope :pesquisaNome, ->(query) { where("nome like ?", "%#{query}%") }
end