class Funcionario < Pessoa

  def self.lista_funcionarios
    pessoas = Funcionario.all;
    funcionarios = [];
    pessoas.each do |funcionario|
      if(funcionario.tipo == 1)
        funcionarios << funcionario
      end
    end

    funcionarios
  end
end