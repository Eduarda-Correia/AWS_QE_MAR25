*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    DateTime
Library    OperatingSystem
Library    BuiltIn
Resource    ../resources/variables.robot

*** Keywords ***
Criar Sessão API
    Create Session    serverest    ${base_url}    verify=${False}

Realizar Login e Armazenar Token
    [Arguments]    ${email}    ${senha}
    ${headers_login}=    Obter Cabeçalhos Sem Autenticação
    ${body}=    Create Dictionary    email=${email}    password=${senha}
    Log    Tentando login com email: ${email}
    Log    Headers do login: ${headers_login}
    Log    Body do login: ${body}
    ${api_response}=    POST On Session    serverest    /login    json=${body}    headers=${headers_login}    verify=${False}
    Log    Resposta do login: ${api_response.json()}
    Should Be Equal As Numbers    ${api_response.status_code}    ${status_ok}    Login falhou
    ${token}=    Set Variable    ${api_response.json()['authorization']}
    Set Suite Variable    ${auth_token}    ${token}
    [Return]    ${api_response}

Obter Token de Autenticação
    [Arguments]    ${email}    ${senha}
    ${payload}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    serverest    /login    json=${payload}    verify=${False}
    ${token}=    Set Variable    ${response.json()['authorization']}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${token}
    [Return]    ${headers}

Obter Cabeçalhos Sem Autenticação
    ${headers}=    Create Dictionary    Content-Type=application/json
    [Return]    ${headers}

Cadastrar Novo Usuário
    [Arguments]    ${payload}    ${headers_arg}=${None}    ${expected_status}=${status_created}
    ${actual_headers}=    Run Keyword If    $headers_arg is None    Obter Cabeçalhos Sem Autenticação
    ...    ELSE    Set Variable    $headers_arg
    ${api_response}=    POST On Session    serverest    /usuarios    json=${payload}    headers=${actual_headers}    expected_status=${expected_status}
    [Return]    ${api_response}

Buscar Usuário
    [Arguments]    ${user_id}    ${headers_arg}=${None}  ${expected_status}=${status_ok}
    ${actual_headers}=    Run Keyword If    $headers_arg is None    Obter Cabeçalhos Sem Autenticação
    ...    ELSE    Set Variable    $headers_arg
    ${api_response}=    GET On Session    serverest    /usuarios/${user_id}    headers=${actual_headers}  expected_status=${expected_status}
    [Return]    ${api_response}

Atualizar Usuário
    [Arguments]    ${user_id}    ${payload}    ${headers_arg}=${None}    ${expected_status}=${status_ok}
    ${actual_headers}=    Run Keyword If    $headers_arg is None    Obter Cabeçalhos Sem Autenticação
    ...    ELSE    Set Variable    $headers_arg
    ${api_response}=    PUT On Session    serverest    /usuarios/${user_id}    json=${payload}    headers=${actual_headers}    expected_status=${expected_status}
    [Return]    ${api_response}

Deletar Usuário
    [Arguments]    ${user_id}    ${headers_arg}=${None}    ${expected_status}=${status_ok}
    ${actual_headers}=    Run Keyword If    $headers_arg is None    Obter Cabeçalhos Sem Autenticação
    ...    ELSE    Set Variable    $headers_arg
    ${api_response}=    DELETE On Session    serverest    /usuarios/${user_id}    headers=${actual_headers}    expected_status=${expected_status}
    [Return]    ${api_response}

Cadastrar Novo Produto
    [Arguments]    ${payload}    ${headers_arg}=${None}    ${expected_status}=${status_created}
    ${api_response}=    POST On Session    serverest    /produtos    json=${payload}    headers=${headers_arg}    expected_status=${expected_status}    verify=${False}
    [Return]    ${api_response}

Criar Carrinho
    [Arguments]    ${payload}    ${headers_arg}=${None}    ${expected_status}=${None}
    ${api_response}=    POST On Session    serverest    /carrinhos    json=${payload}    headers=${headers_arg}    expected_status=${expected_status}    verify=${False}
    [Return]    ${api_response}

Gerar Dados de Novo Usuário Válido
    ${random}=    Generate Random String    8    [LETTERS][NUMBERS]
    ${email}=    Set Variable    usuario_${random}@qa.com
    ${payload}=    Create Dictionary
    ...    nome=Fulano ${random}
    ...    email=${email}
    ...    password=teste
    ...    administrador=true
    [Return]    ${payload}

Gerar Dados de Usuário com Email Gmail
    ${random}=    Generate Random String    8    [LETTERS][NUMBERS]
    ${payload}=    Create Dictionary
    ...    nome=Fulano ${random}
    ...    email=teste_${random}@gmail.com  
    ...    password=teste
    ...    administrador=true
    [Return]    ${payload}

Gerar Dados de Usuário com Senha Longa
    ${random}=    Generate Random String    8    [LETTERS][NUMBERS]
    ${email}=    Set Variable    longpass_${random}@qa.com
    ${payload}=    Create Dictionary
    ...    nome=Fulano ${random}
    ...    email=${email}
    ...    password=senha_muito_longa_1234567890
    ...    administrador=true
    [Return]    ${payload}

Gerar Dados de Usuário com Senha Curta
    ${random}=    Generate Random String    8    [LETTERS][NUMBERS]
    ${email}=    Set Variable    shortpass_${random}@qa.com
    ${payload}=    Create Dictionary
    ...    nome=Fulano ${random}
    ...    email=${email}
    ...    password=1234
    ...    administrador=true
    [Return]    ${payload}

Gerar Dados de Usuário Sem Senha
    ${random}=    Generate Random String    8    [LETTERS][NUMBERS]
    ${email}=    Set Variable    nopass_${random}@qa.com
    ${payload}=    Create Dictionary
    ...    nome=Fulano ${random}
    ...    email=${email}
    ...    administrador=true # Adicionado para consistência, API pode exigir
    [Return]    ${payload}

Gerar Dados de Novo Produto Válido
    ${random}=    Generate Random String    8    [LETTERS][NUMBERS]
    ${payload}=    Create Dictionary
    ...    nome=Produto ${random}
    ...    preco=100
    ...    descricao=Descrição do produto ${random}
    ...    quantidade=10
    [Return]    ${payload}

Validar Status Code
    [Arguments]    ${api_response_obj}    ${expected_status}
    Should Be Equal As Numbers    ${api_response_obj.status_code}    ${expected_status}

Validar Mensagem de Resposta
    [Arguments]    ${api_response_obj}    ${expected_message}
    ${json_body}=    Evaluate    $api_response_obj.json()
    ${message_found}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${json_body}    message
    IF    ${message_found}
        ${actual_message}=    Get From Dictionary    ${json_body}    message
        Should Be Equal As Strings    ${actual_message}    ${expected_message}
    ELSE
        Dictionary Should Contain Value    ${json_body}    ${expected_message}
    END

Verificar Presença de Campo no JSON
    [Arguments]    ${api_response_obj}    ${field}
    ${json_body}=    Evaluate    $api_response_obj.json()
    Dictionary Should Contain Key    ${json_body}    ${field}

Verificar Ausência de Campo no JSON
    [Arguments]    ${api_response_obj}    ${field}
    ${json_body}=    Evaluate    $api_response_obj.json()
    Dictionary Should Not Contain Key    ${json_body}    ${field}

Verificar Lista Não Vazia
    [Arguments]    ${api_response_obj}    ${list_field}
    ${json_body}=    Evaluate    $api_response_obj.json()
    Dictionary Should Contain Key    ${json_body}    ${list_field}
    ${lista}=    Get From Dictionary    ${json_body}    ${list_field}
    Should Not Be Empty    ${lista}

Verificar Lista Vazia
    [Arguments]    ${api_response_obj}    ${list_field}
    ${json_body}=    Evaluate    $api_response_obj.json()
    Dictionary Should Contain Key    ${json_body}    ${list_field}
    ${lista}=    Get From Dictionary    ${json_body}    ${list_field}
    Should Be Empty    ${lista}

Realizar Login e Limpar Carrinho
    [Arguments]    ${email}    ${senha}
    [Documentation]    Faz o login e garante que não há carrinhos ativos para o usuário.
    Realizar Login e Armazenar Token    ${email}    ${senha}
    Concluir Compra e Limpar Carrinho

Concluir Compra e Limpar Carrinho
    [Documentation]    Executa a rotina para deletar um carrinho existente. Ignora falhas caso o carrinho não exista.
    ${headers}=    Obter Headers de Autenticação
    ${response}=    DELETE On Session    serverest    /carrinhos/concluir-compra
    ...    headers=${headers}
    ...    expected_status=any    # Aceita qualquer status, pois o carrinho pode não existir
    Log    Tentativa de limpeza de carrinho concluída com status: ${response.status_code}

Obter Headers de Autenticação
    [Documentation]    Retorna o cabeçalho de autenticação usando o token armazenado na suíte.
    IF    '${auth_token}' == '${None}'
        Fail    Token de autenticação não encontrado. Execute 'Realizar Login e Armazenar Token' primeiro.
    END
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${auth_token}
    [Return]    ${headers}

*** Keywords ***
Gerar Payload de Carrinho com Produto
    [Arguments]    ${produto_id}    ${quantidade}
    [Documentation]    Cria a estrutura de dados (payload) para adicionar um produto ao carrinho.
    ${produto_item}=    Create Dictionary    idProduto=${produto_id}    quantidade=${quantidade}
    @{produtos_list}=    Create List    ${produto_item}
    ${payload}=    Create Dictionary    produtos=${produtos_list}
    [Return]    ${payload}