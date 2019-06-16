class ValidacoesAuxPessoa < ActiveModel::Validator
  def validate(pessoa)
    if Pessoa.verificarExisteCpfAtivo(pessoa) != nil
      pessoa.errors[:base] << "Cpf não pode ser repetido"
    end
    if Pessoa.verificarExisteEmailAtivo(pessoa) != nil
      pessoa.errors[:base] << "E-mail não pode ser repetido"
    end
  end
end