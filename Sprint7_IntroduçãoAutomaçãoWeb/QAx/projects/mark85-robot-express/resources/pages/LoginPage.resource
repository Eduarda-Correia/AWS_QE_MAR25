*** Settings ***
Documentation    Ações e elementos da página de Login

Library    Browser

*** Keywords ***
Submit login form
    [Arguments]    ${user}

    Fill Text    css=input[placeholder$=mail]    ${user}[email]        #o $ significa que termina com mail
    Fill Text    css=input[placeholder=Senha]    ${user}[password]

    #Click    xpath=//button[text()="entrar"]
    Click    css=button >> text=Entrar

 