*** Settings ***
Documentation     Testes de API para o endpoint /login
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot

Suite Setup     Criar Sessão API

*** Test Cases ***
CT06 - Login: Login com credenciais válidas - Positivo
    ${response_obj}=    Realizar Login e Armazenar Token    ${admin_email}    ${admin_senha}
    Validar Status Code    ${response_obj}    ${status_ok}
    Verificar Presença de Campo no JSON    ${response_obj}    authorization
    ${token_from_response}=  Get From Dictionary  ${response_obj.json()}  authorization
    Should Not Be Empty    ${token_from_response}
    Should Not Be Empty    ${auth_token}    # Verifica o token global também

CT07 - Login: Login com senha inválida - Negativo
    ${headers}=    Obter Cabeçalhos Sem Autenticação
    ${body}=    Create Dictionary    email=${admin_email}    password=senha_errada
    ${response_obj}=    POST On Session    serverest    /login    json=${body}    headers=${headers}    expected_status=${status_unauthorized}
    Validar Status Code    ${response_obj}    ${status_unauthorized}
    Validar Mensagem de Resposta    ${response_obj}    Email e/ou senha inválidos

CT08 - Login: Tentar acessar recurso com token inválido - Negativo    #No postman eu usei um token bearer que teoricamente já tinha expirado
    [Tags]    BUG
    ${login_resp}=    Realizar Login e Armazenar Token    ${admin_email}    ${admin_senha}    # Para garantir que um token válido foi gerado antes
    ${headers_invalid_token}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer token_invalido
    ${response_obj}=    GET On Session    serverest    /produtos    headers=${headers_invalid_token}    expected_status=${status_unauthorized}
    Validar Status Code    ${response_obj}    ${status_unauthorized}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_token_invalido}

CT21 - Login: Login com e-mail inexistente - Negativo
    [Tags]    Extra_Chal03    
    ${headers}=    Obter Cabeçalhos Sem Autenticação
    ${body}=    Create Dictionary    email=inexistente@qa.com    password=teste
    ${response_obj}=    POST On Session    serverest    /login    json=${body}    headers=${headers}    expected_status=${status_unauthorized}    # Serverest retorna 401 para email/senha errados
    Validar Status Code    ${response_obj}    ${status_unauthorized}
    Validar Mensagem de Resposta    ${response_obj}    Email e/ou senha inválidos

CT22 - Login: Login com campos obrigatórios ausentes (sem senha)
    [Tags]    Extra_Chal03
    ${headers}=    Obter Cabeçalhos Sem Autenticação
    ${body}=    Create Dictionary    email=teste@qa.com
    ${response_obj}=    POST On Session    serverest    /login    json=${body}    headers=${headers}    expected_status=${status_bad_request}
    Validar Status Code    ${response_obj}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_obj}    password é obrigatório