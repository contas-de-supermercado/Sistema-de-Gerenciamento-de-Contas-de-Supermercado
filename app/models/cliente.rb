class Cliente < Pessoa

  def self.pesquisa query
    clientes = listaClientes
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

  def self.buscarClientePorCpf cpf
    clientes = listaClientes
    clientes.each do |cliente|
      if cliente.cpf == cpf
        return cliente
      end
    end
    return nil
  end

  scope :listaClientes, -> { where("inativo like ?", "%#{0}%") }
  scope :pesquisaId, ->(query) { where("id like ?", "%#{query}%") }
  scope :pesquisaCpf, ->(query) { where("cpf like ?", "%#{query}%") }
  scope :pesquisaNome, ->(query) { where("nome like ?", "%#{query}%") }

end