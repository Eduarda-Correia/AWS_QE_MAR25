*** Settings ***
Documentation     Testes de API para o endpoint /usuarios
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot

Suite Setup     Criar Sessão API

*** Test Cases ***
CT01 - Usuários: Criar usuário com dados válidos - Positivo
    ${payload}=    Gerar Dados de Novo Usuário Válido
    ${response_obj}=    Cadastrar Novo Usuário    ${payload}    expected_status=${status_created}
    Validar Status Code    ${response_obj}    ${status_created}
    Verificar Presença de Campo no JSON    ${response_obj}    _id
    Verificar Presença de Campo no JSON    ${response_obj}    message

CT02 - Usuários: Criar usuário com e-mail já utilizado - Negativo
    ${payload}=    Gerar Dados de Novo Usuário Válido
    ${response_cadastro1}=    Cadastrar Novo Usuário    ${payload}
    Validar Status Code    ${response_cadastro1}    ${status_created} 
    ${payload['email']}=    Set Variable    ${payload['email']} 
    ${response_cadastro2}=    Cadastrar Novo Usuário    ${payload}    expected_status=${status_bad_request}
    Validar Status Code    ${response_cadastro2}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_cadastro2}    ${msg_email_ja_cadastrado}

CT03 - Usuários: Criar usuário com e-mail Gmail - Negativo
    [Tags]    BUG
    # Nota: A API Serverest padrão PERMITE e-mails @gmail.com. Mas é uma quebra da regra de negócio, sendo assim, o teste deveria retornar um erro.
    ${payload}=    Gerar Dados de Usuário com Email Gmail
    ${response_obj}=    Cadastrar Novo Usuário    ${payload}    expected_status=${status_bad_request}
    Validar Status Code    ${response_obj}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_email_invalido}

CT04 - Usuários: Criar usuário com senha muito longa - Negativo
    [Tags]    BUG
    # Nota: Verifique se a sua API Serverest realmente impõe esse limite e mensagem.
    ${payload}=    Gerar Dados de Usuário com Senha Longa
    ${response_obj}=    Cadastrar Novo Usuário    ${payload}    expected_status=${status_bad_request}
    Validar Status Code    ${response_obj}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_senha_longa}

CT05 - Usuários: Criar usuário com senha muito curta - Negativo
    [Tags]    BUG
    # Nota: Verifique se a sua API Serverest realmente impõe esse limite e mensagem.
    ${payload}=    Gerar Dados de Usuário com Senha Curta
    ${response_obj}=    Cadastrar Novo Usuário    ${payload}    expected_status=${status_bad_request}
    Validar Status Code    ${response_obj}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_senha_curta}

CT18 - Usuários: Criar usuário sem senha - Negativo
    [Tags]    Extra_Chal03
    ${payload}=    Gerar Dados de Usuário Sem Senha
    ${response_obj}=    Cadastrar Novo Usuário    ${payload}    expected_status=${status_bad_request}
    Validar Status Code    ${response_obj}    ${status_bad_request}
    Validar Mensagem de Resposta    ${response_obj}    ${msg_senha_obrigatoria}

CT19 - Usuários: Atualizar usuário com ID inexistente - Positivo
    [Tags]    Extra_Chal03
    ${payload}=    Gerar Dados de Novo Usuário Válido
    ${id_inexistente}=  Generate Random String  12  [ALPHANUMERIC]
    ${response_obj}=    Atualizar Usuário    ${id_inexistente}    ${payload}    expected_status=${status_created}
    Validar Status Code    ${response_obj}    ${status_created}
    Validar Mensagem de Resposta    ${response_obj}    Cadastro realizado com sucesso


CT20 - Usuários: Tentar listar usuários sem autenticação - Positivo
    [Tags]    Extra_Chal03
    ${headers_no_auth}=  Obter Cabeçalhos Sem Autenticação
    ${response_obj}=    GET On Session    serverest    /usuarios  headers=${headers_no_auth}
    Validar Status Code    ${response_obj}    ${status_ok}
    Verificar Lista Não Vazia    ${response_obj}    usuarios