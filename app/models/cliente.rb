class Cliente < Pessoa

  def self.pesquisa query
    clientes = listaClientes(0);
    pesquisaIds = clientes.pesquisaId(query)
    pesquisaCpfs = clientes.pesquisaCpf(query)
    pesquisaNomes = clientes.pesquisaNome(query)
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

  scope :listaClientes, ->(query) { where("tipo like ?", "%#{query}%") }
  scope :pesquisaId, ->(query) { where("id like ?", "%#{query}%") }
  scope :pesquisaCpf, ->(query) { where("cpf like ?", "%#{query}%") }
  scope :pesquisaNome, ->(query) { where("nome like ?", "%#{query}%") }

end