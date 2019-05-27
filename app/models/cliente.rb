class Cliente < Pessoa
  attr_accessor :ficheiro

  def self.lista_clientes
    pessoas = Cliente.all;
    clientes = [];
    pessoas.each do |cliente|
      if(cliente.tipo == 0)
        clientes << cliente
      end
    end

    clientes
  end

end