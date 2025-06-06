*** Settings ***
Documentation     Testes de API para o endpoint /produtos
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot

Suite Setup     Criar Sessão API

*** Test Cases ***
CT09 - Produtos: Criar produto autenticado - Positivo
    ${login_resp}=  Realizar Login e Armazenar Token    ${admin_email}    ${admin_senha}    # Garante que ${auth_token} está setado
    ${headers}=    Obter Token de Autenticação    ${admin_email}    ${admin_senha}
    ${payload}=    Gerar Dados de Novo Produto Válido
    ${response_obj}=    Cadastrar Novo Produto    ${payload}    headers_arg=${headers}    expected_status=${status_created}
    Validar Status Code    ${response_obj}    ${status_created}
    Verificar Presença de Campo no JSON    ${response_obj}    _id
    Verificar Presença de Campo no JSON    ${response_obj}    message

CT10 - Produtos: Criar produto com nome duplicado - Negativo
    ${login_resp}=  Realizar Login e Armazenar Token    ${admin_email}    ${admin_senha}
    ${headers}=    Obter Token de Autenticação    ${admin_email}    ${admin_senha}
    ${payload}=    Gerar Dados de Novo Produto Válido    # Mesmo payload será usado duas vezes

    ${response_prod1}=    Cadastrar Novo Produto    ${payload}    headers_arg=${headers}
    Validar Status Code    ${response_prod1}    ${status_created}

    ${response_prod2}=    Cadastrar Novo Produto    ${payload}    headers_arg=${headers}    expected_status=${status_bad_request}
    Validar Status Code    ${response_prod2}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_prod2}    Já existe produto com esse nome

*** Test Cases ***
CT11 - Produtos: Tentar excluir produto que já está em carrinho - Negativo
    [Documentation]    Verifica que a API impede a exclusão de um produto que está em um carrinho.
    [Tags]    Produtos    Carrinhos    Negativo
    [Setup]    Realizar Login e Limpar Carrinho    ${admin_email}    ${admin_senha}

    # Gera o token de autenticação para as próximas requisições
    ${headers}=    Obter Headers de Autenticação

    # Cadastra um novo produto
    ${payload_produto}=    Gerar Dados de Novo Produto Válido
    ${response_produto}=    Cadastrar Novo Produto    ${payload_produto}    headers_arg=${headers}
    Validar Status Code    ${response_produto}    ${status_created}
    ${produto_id}=    Set Variable    ${response_produto.json()['_id']}

    # Adiciona o produto a um carrinho
    ${payload_carrinho}=    Gerar Payload de Carrinho com Produto    ${produto_id}    1
    ${response_carrinho}=    Criar Carrinho    ${payload_carrinho}    headers_arg=${headers}
    Validar Status Code    ${response_carrinho}    ${status_created}

    # Tenta deletar o produto que está no carrinho
    ${response_delete}=    DELETE On Session    serverest    /produtos/${produto_id}    headers=${headers}    expected_status=${status_bad_request}
    Validar Status Code    ${response_delete}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_delete}    Não é permitido excluir produto que faz parte de carrinho

CT12 - Produtos: Tentar criar produto sem autenticação - Negativo
    ${payload}=    Gerar Dados de Novo Produto Válido
    ${headers_no_auth}=  Obter Cabeçalhos Sem Autenticação
    ${response_obj}=    Cadastrar Novo Produto    ${payload}    headers_arg=${headers_no_auth}    expected_status=${status_unauthorized}
    Validar Status Code    ${response_obj}    ${status_unauthorized}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_token_invalido}

CT13 - Produtos: Tentar listar produtos sem autenticação - Positivo
    ${headers_no_auth}=  Obter Cabeçalhos Sem Autenticação
    ${response_obj}=    GET On Session    serverest    /produtos  headers=${headers_no_auth}
    Validar Status Code    ${response_obj}    ${status_ok}
    Verificar Lista Não Vazia    ${response_obj}    produtos

CT14 - Produtos: Tentar atualizar produto sem autenticação - Negativo
    ${payload}=    Gerar Dados de Novo Produto Válido
    ${headers_no_auth}=  Obter Cabeçalhos Sem Autenticação
    ${id_produto_aleatorio}=  Generate Random String  10  [ALPHANUMERIC]
    ${response_obj}=    PUT On Session    serverest    /produtos/${id_produto_aleatorio}    json=${payload}    headers=${headers_no_auth}    expected_status=${status_unauthorized}
    Validar Status Code    ${response_obj}    ${status_unauthorized}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_token_invalido}

CT15 - Produtos: Tentar excluir produto sem autenticação - Negativo
    ${headers_no_auth}=  Obter Cabeçalhos Sem Autenticação
    ${id_produto_aleatorio}=  Generate Random String  10  [ALPHANUMERIC]
    ${response_obj}=    DELETE On Session    serverest    /produtos/${id_produto_aleatorio}    headers=${headers_no_auth}    expected_status=${status_unauthorized}
    Validar Status Code    ${response_obj}    ${status_unauthorized}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_token_invalido}