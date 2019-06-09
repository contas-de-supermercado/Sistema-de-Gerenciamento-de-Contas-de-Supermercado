class Cliente < Pessoa

  def self.pesquisa query
    pesquisaIds = Cliente.pesquisaId(query)
    pesquisaCpfs = Cliente.pesquisaCpf(query)
    pesquisaNomes = Cliente.pesquisaNome(query)
    resultado = []
    pesquisaIds.each do |cliente|
      resultado << cliente
    end
    pesquisaCpfs.each do |cliente|
      if(!resultado.index(cliente))
        resultado << cliente
      end
    end
    pesquisaNomes.each do |cliente|
      if(!resultado.index(cliente))
        resultado << cliente
      end
    end
    resultado
  end

  scope :listaClientes, -> { where("inativo like ?", "%#{0}%") }
  scope :pesquisaId, ->(query) { where("id like ?", "%#{query}%") }
  scope :pesquisaCpf, ->(query) { where("cpf like ?", "%#{query}%") }
  scope :pesquisaNome, ->(query) { where("nome like ?", "%#{query}%") }

end