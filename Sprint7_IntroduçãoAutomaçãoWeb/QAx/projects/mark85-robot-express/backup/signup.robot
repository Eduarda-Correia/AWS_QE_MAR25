*** Settings ***
Documentation    Cenários de teste do cadastro de usuários

Resource    ../resources/base.resource

Test Setup    Start Session            #todo inicio de teste
Test Teardown    Take Screenshot       #todo fim de teste

*** Test Cases ***
CT01 - Deve poder cadastrar um novo usuário
    [Tags]    POSITIVO

    ${user}    Create Dictionary    
    ...    name=Maria Eduarda    
    ...    email=mariateste@gmail.com    
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Go to signup Page
    Submit signup form    ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.

    #Sleep    5 #Tempo de espera

CT02 - Não deve permitir o cadastro com email duplicado
    [Tags]    NEGATIVO

    ${user}    Create Dictionary    
    ...    name=Maria    
    ...    email=maria@gmail.com    
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Go to signup Page
    Submit signup form    ${user}
    Notice should be    Oops! Já existe uma conta com o e-mail informado.

CT03 - Campos obrigatórios vazios
    [Tags]    NEGATIVO    required

    ${user}    Create Dictionary
    ...        name=${EMPTY}
    ...        email=${EMPTY}
    ...        password=${EMPTY}
        
    Go to signup Page
    Submit signup form    ${user}
    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

CT04 - Não deve cadastrar com email incorreto
    [Tags]    NEGATIVO    inv_email

    ${user}    Create Dictionary
    ...    name=Charles Xavier
    ...    email=xavier.com.br
    ...    password=123456

    Go to signup Page
    Submit signup form    ${user}
    Alert should be    Digite um e-mail válido

CT05 - Não deve cadastrar com senhas muito curtas
    [Tags]    NEGATIVO    short_pass    temp
    
    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
        ${user}    Create Dictionary
        ...        name=Maria
        ...        email=mariateste@gmail.com
        ...        password=${password}
            
        Go to signup Page
        Submit signup form    ${user}
        Alert should be    Informe uma senha com pelo menos 6 digitos
    END

CT06 - Não deve cadastrar com senha de 1 dígito
    [Tags]    NEGATIVO    short_pass
    [Template]
    Short password    1

CT07 - Não deve cadastrar com senha de 5 dígitos
    [Tags]    NEGATIVO    short_pass
    [Template]
    Short password    12345

