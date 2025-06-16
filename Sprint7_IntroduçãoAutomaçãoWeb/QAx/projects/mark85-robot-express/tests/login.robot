*** Settings ***
Documentation    Cenários de autenticação de usuário

Library      Collections
Resource    ../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
CT01 - Deve poder logar com um usuário pré-cadastrado
    [Tags]    POSITIVO

    ${user}    Create Dictionary    
    ...    name=Maria Eduarda    
    ...    email=mariateste@gmail.com    
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login form           ${user}
    User should be logged in    ${user}[name]

CT02 - Não deve logar com senha inválida
    [Tags]    NEGATIVO

    ${user}    Create Dictionary    
    ...    name=Steve Woz  
    ...    email=woz@apple.com    
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=abc123

    Submit login form           ${user}
    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.