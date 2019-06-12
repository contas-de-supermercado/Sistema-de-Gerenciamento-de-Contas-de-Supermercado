class PagamentosController < ApplicationController
  respond_to :js, :html

  def index
    segurancaLogin(1)
    if(params[:pesquisa] &&  params[:pesquisa] != '')
      @clientes = Cliente.pesquisa(params[:pesquisa])
    else
      @clientes = Cliente.listaClientes
    end

    @contasDevendo = [];
    @contasAtrasadas = [];
    @cliente = Cliente.new
  end

  def show
    segurancaLogin(1)
    carregarContas(params[:id])
    @cliente = Cliente.find(params[:id])
    render 'pagamentos/index'
  end

  def create
    segurancaLogin(1)
    cpf = params[:cpf]
    valorContas = params[:valorContas]
    valorCliente = params[:valorCliente]
    cliente = nil
    if (cliente = validarDadosPagamento cpf, valorContas, valorCliente) != nil
      valorContas = valorContas.to_f
      valorCliente = valorCliente.to_f
      pagamentoCaso1 params[:idsContasDevendo], params[:idsContasAtrasada], valorCliente, valorContas
      pagamentoCaso2 params[:idsContasDevendo], params[:idsContasAtrasada], valorCliente, valorContas
      carregarContas cliente.id
    end
  end

  private

  def segurancaLogin pessoa
    if pessoa == 1
      if Pessoa.getPessoaLogada() == nil || Pessoa.getPessoaLogada().tipo != 1
        redirect_to logins_path
      end
    else
      if Pessoa.getPessoaLogada() == nil || Pessoa.getPessoaLogada().tipo != 0
        redirect_to logins_path
      end
    end
  end

  # Caso quando o valor dado pelo cliente é maior ou igual do que o valor das contas selecionadas
  def pagamentoCaso1 idsContasDevendo, idsContasAtrasada, valorCliente, valorContas
    if valorCliente >= valorContas
      contas = idsContasAtrasada + idsContasDevendo
      contas = contas.split('-')
      contas.each do |conta|
        if conta != ""
          conta = Contum.find(conta)
          conta.update(status: "Paga", dataPagamento: Time.now.to_s)
        end
      end
      @resultadoPagamento = "Pagamento Efetuado: Troco = " + (valorCliente - valorContas).to_s;
    end
  end

  # Caso quando o valor dado pelo cliente é menor do que o valor das contas selecionadas
  def pagamentoCaso2 idsContasDevendo, idsContasAtrasada, valorCliente, valorContas
    if valorCliente < valorContas
      valorPago = 0
      contas = idsContasAtrasada + idsContasDevendo
      contas = contas.split('-')
      contas.each do |conta|
        if conta != ""
          if valorCliente > valorPago
            conta = Contum.find(conta)
            valor = conta.valor
            if conta.juros > 0
              valor += (conta.juros/100) * valor;
            end
            if (valorCliente - valorPago) >= valor
              conta.update(status: "Paga", dataPagamento: Time.now)
            else
              valor -= (valorCliente - valorPago)
              conta.update(valor: valor)
            end
            valorPago += valor
          end
        end
      end
      @resultadoPagamento = "restante-Pagamento Efetuado: Restante = " + (valorContas - valorCliente).to_s;
    end
  end

  def validarDadosPagamento cpf, valorContas, valorCliente
    resultado = nil
    if verificarVazioOuNulo(cpf) || cpf.length != 11 || !verificarNumeroInt(cpf)
      @resultadoPagamento = "erro-Preenchar um cpf válido"
    elsif verificarVazioOuNulo(valorContas) || valorContas.to_s == '0'
      @resultadoPagamento = "erro-Nenhuma conta foi selecionada"
    elsif verificarVazioOuNulo(valorCliente)
      @resultadoPagamento = "erro-Preencha o valor dado pelo cliente"
    elsif !verificarNumeroFloat(valorCliente)
      @resultadoPagamento = "erro-Preencha um valor dado pelo cliente válido"
    elsif (resultado = Cliente.buscarClientePorCpf cpf) == nil
      @resultadoPagamento = "erro-Esse cliente não existe"
    end
    resultado
  end

  def verificarVazioOuNulo string
    resultado = false
    if string == nil or string == ''
      resultado = true
    end
    resultado
  end

  def verificarNumeroInt string
    resultado = true
    begin
      string = string.to_i
      if string == 0
        resultado = false
      end
    rescue
      resultado = false
    end
    resultado
  end

  def verificarNumeroFloat string
    resultado = true
    begin
      string = string.to_f
      if string == 0
        resultado = false
      end
    rescue
      resultado = false
    end
    resultado
  end

  def carregarContas id
    contas = Contum.listaContasCliente(id)
    @contasDevendo = contas.listaContasDevendo
    @contasAtrasadas = contas.listaContasAtrasadas
    @clientes = Cliente.listaClientes
  end
end
