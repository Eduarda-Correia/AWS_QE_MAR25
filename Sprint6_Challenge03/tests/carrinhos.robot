*** Settings ***
Documentation     Testes de API para o endpoint /carrinhos
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot

Suite Setup     Criar Sessão API

*** Test Cases ***
CT16 - Carrinho: Criar carrinho com produtos válidos - Positivo
    [Setup]    Realizar Login e Limpar Carrinho    ${admin_email}    ${admin_senha}

    ${headers}=    Obter Headers de Autenticação
    ${payload_produto}=    Gerar Dados de Novo Produto Válido
    ${response_produto}=    Cadastrar Novo Produto    ${payload_produto}    headers_arg=${headers}
    Validar Status Code    ${response_produto}    ${status_created}
    ${produto_id}=    Set Variable    ${response_produto.json()['_id']}

    ${payload_carrinho}=    Gerar Payload de Carrinho com Produto    ${produto_id}    1
    ${response_obj}=    Criar Carrinho    ${payload_carrinho}    headers_arg=${headers}    expected_status=${status_created}

    Validar Status Code    ${response_obj}    ${status_created}
    Validar Mensagem de Resposta    ${response_obj}    Cadastro realizado com sucesso
    Verificar Presença de Campo no JSON    ${response_obj}    _id

CT17 - Carrinho: Criar dois carrinhos com mesmo usuário - Negativo
    [Setup]    Realizar Login e Limpar Carrinho    ${admin_email}    ${admin_senha}

    ${headers}=    Obter Headers de Autenticação
    ${payload_produto}=    Gerar Dados de Novo Produto Válido
    ${response_produto}=    Cadastrar Novo Produto    ${payload_produto}    headers_arg=${headers}
    ${produto_id}=    Set Variable    ${response_produto.json()['_id']}

    # Primeiro carrinho (deve ser criado com sucesso)
    ${payload_carrinho1}=    Gerar Payload de Carrinho com Produto    ${produto_id}    1
    ${response_carrinho1}=    Criar Carrinho    ${payload_carrinho1}    headers_arg=${headers}
    Validar Status Code    ${response_carrinho1}    ${status_created}

    # Segundo carrinho (deve falhar)
    ${payload_carrinho2}=    Gerar Payload de Carrinho com Produto    ${produto_id}    2
    ${response_carrinho2}=    Criar Carrinho    ${payload_carrinho2}    headers_arg=${headers}    expected_status=${status_bad_request}
    Validar Status Code    ${response_carrinho2}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_carrinho2}    ${msg_carrinho_duplicado}

CT18 - Carrinho: Tentar criar carrinho sem autenticação - Negativo
    # Setup: Criar um produto com um usuário admin para obter um ID válido.
    ${login_admin_resp}=    Realizar Login e Armazenar Token    ${admin_email}    ${admin_senha}
    ${headers_admin}=    Obter Headers de Autenticação
    ${payload_prod}=    Gerar Dados de Novo Produto Válido
    ${resp_prod}=    Cadastrar Novo Produto    ${payload_prod}    headers_arg=${headers_admin}
    Validar Status Code    ${resp_prod}    ${status_created}
    ${produto_id_valido}=    Set Variable    ${resp_prod.json()['_id']}

    # Teste: Tentar criar o carrinho sem token de autenticação
    ${payload_carrinho}=    Gerar Payload de Carrinho com Produto    ${produto_id_valido}    1
    ${headers_no_auth}=    Obter Cabeçalhos Sem Autenticação
    ${response_obj}=    Criar Carrinho    ${payload_carrinho}    headers_arg=${headers_no_auth}    expected_status=${status_unauthorized}

    Validar Status Code    ${response_obj}    ${status_unauthorized}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_token_invalido}
