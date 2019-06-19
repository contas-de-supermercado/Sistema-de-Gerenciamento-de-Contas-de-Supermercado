// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

function selecionarCpfCliente(cpf){

    var cpfCliente = document.getElementById('cliente');
    cpfCliente.value = cpf;
}

function selecionarCpfFuncionario(cpf){

    var cpfCliente = document.getElementById('funcionario');
    cpfCliente.value = cpf;
}

valorContaDevendo = 0;

function setValorContaDevendo(valor) {
    valorContaDevendo = valor;
    document.getElementById('contasDevendo').innerHTML = 'Contas Devendo = 0';
    document.getElementById('valorContas').value = '0';
}

function somarContasDevendo(conta, valor) {
    valorContaDevendo += valor
    document.getElementById('contasDevendo').innerHTML = 'Contas Devendo = ' + valorContaDevendo;
    document.getElementById('valorContas').value = valorContaDevendo + valorContaAtrasada;
    contasDevendoSelecionadas(conta, true)
}

function selecionarContaDevendo(clickedid, valor) {
    if (document.getElementById(clickedid).checked == true) { // deixar ele true
        valorContaDevendo += valor;
        document.getElementById('contasDevendo').innerHTML = 'Contas Devendo = ' + valorContaDevendo;
        contasDevendoSelecionadas(clickedid, true);
    } else {  // deixar ele falso
        valorContaDevendo -= valor;
        document.getElementById('contasDevendo').innerHTML = 'Contas Devendo = ' + valorContaDevendo;
        contasDevendoSelecionadas(clickedid, false);
    }
    document.getElementById('valorContas').value = valorContaDevendo + valorContaAtrasada;
}

valorContaAtrasada = 0;

function setValorContaAtrasada(valor) {
    valorContaAtrasada = valor;
    document.getElementById('contasAtrasada').innerHTML = 'Contas Atrasadas = 0';
    document.getElementById('valorContas').value = '0';
}

function somarContasAtrasada(conta, valor) {
    valorContaAtrasada += valor;
    document.getElementById('contasAtrasada').innerHTML = 'Contas Atrasadas = ' + valorContaAtrasada;
    document.getElementById('valorContas').value = valorContaDevendo + valorContaAtrasada;
    contasAtrasadaSelecionadas(conta, true);
}

function selecionarContaAtrasada(clickedid, valor) {
    if (document.getElementById(clickedid).checked == true) { // deixar ele true
        valorContaAtrasada += valor;
        document.getElementById('contasAtrasada').innerHTML = 'Contas Atrasadas = ' + valorContaAtrasada;
        contasAtrasadaSelecionadas(clickedid, true);
    } else {  // deixar ele falso
        valorContaAtrasada -= valor;
        document.getElementById('contasAtrasada').innerHTML = 'Contas Atrasadas = ' + valorContaAtrasada;
        contasAtrasadaSelecionadas(clickedid, false);
    }
    document.getElementById('valorContas').value = valorContaDevendo + valorContaAtrasada;
}

function contasDevendoSelecionadas(conta, flag) {
    var ids = document.getElementById('idsContasDevendoSelecionadas');
    if(flag == true){
        ids.value += "-" + conta;
    }
    else{
        var resultado = ids.value.split('-');
        var result = "";
        for(var i = 0; i < resultado.length; i++){
            if(resultado[i] != '' && conta.toString() != resultado[i]){
                result += "-" + resultado[i];
            }
        }
        ids.value = result;
    }
}

function contasAtrasadaSelecionadas(conta, flag) {
    var ids = document.getElementById('idsContasAtrasadaSelecionadas');
    if(flag == true){
        ids.value += "-" + conta;
    }
    else{
        var resultado = ids.value.split('-');
        var result = "";
        for(var i = 0; i < resultado.length; i++){
            if(resultado[i] != '' && conta.toString() != resultado[i]){
                result += "-" + resultado[i];
            }
        }
        ids.value = result;
    }
}

function selecionarCpfNomeCliente(nome, cpf) {
    document.getElementById('cpf').value = cpf;
    document.getElementById('nome').value = nome;
}

valorContaPagas = 0;

function somarContasPagasCliente(valor) {
    valorContaPagas += valor;
    document.getElementById('contasPagas').innerHTML = 'Contas Pagas = ' + valorContaPagas;
}
function selecionarContaPagasCliente(clickedid, valor) {
    if (document.getElementById(clickedid).checked == true) { // deixar ele true
        valorContaPagas += valor;
        document.getElementById('contasPagas').innerHTML = 'Contas Pagas = ' + valorContaPagas;
    } else {  // deixar ele falso
        valorContaPagas -= valor;
        document.getElementById('contasPagas').innerHTML = 'Contas Pagas = ' + valorContaPagas;
    }
}

function somarContasDevendoCliente(valor) {
    valorContaDevendo += valor;
    document.getElementById('contasDevendoCliente').innerHTML = 'Contas Devendo = ' + valorContaDevendo;
}
function selecionarContaDevendoCliente(clickedid, valor) {
    if (document.getElementById(clickedid).checked == true) { // deixar ele true
        valorContaDevendo += valor;
        document.getElementById('contasDevendoCliente').innerHTML = 'Contas Devendo = ' + valorContaDevendo;
    } else {  // deixar ele falso
        valorContaDevendo -= valor;
        document.getElementById('contasDevendoCliente').innerHTML = 'Contas Devendo = ' + valorContaDevendo;
    }
}

function somarContasAtrasadasCliente(valor) {
    valorContaAtrasada += valor;
    document.getElementById('contasAtrasada').innerHTML = 'Contas Atrasadas = ' + valorContaAtrasada;
}
function selecionarContaAtrasadaCliente(clickedid, valor) {
    if (document.getElementById(clickedid).checked == true) { // deixar ele true
        valorContaAtrasada += valor;
        document.getElementById('contasAtrasada').innerHTML = 'Contas Atrasadas = ' + valorContaAtrasada;
    } else {  // deixar ele falso
        valorContaAtrasada -= valor;
        document.getElementById('contasAtrasada').innerHTML = 'Contas Atrasadas = ' + valorContaAtrasada;
    }
}