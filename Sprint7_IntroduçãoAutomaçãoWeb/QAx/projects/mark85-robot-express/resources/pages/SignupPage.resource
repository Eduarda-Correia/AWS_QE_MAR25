*** Settings ***    
Documentation    Elementos e ações da página de cadastro

Library    Browser
Resource    ../env.resource

*** Keywords ***
Go to signup Page
    Go To    ${BASE_URL}/signup

    #Checkpoint
    Wait For Elements State    xpath=//h1    visible    5
    Get Text                   css=h1    equal    Faça seu cadastro
Submit signup form
    [Arguments]    ${user}
    Fill Text    css=input[name=name]          ${user}[name]
    Fill Text    css=input[name=email]         ${user}[email]            #usamos esse modo de procura para seguir o padrão de projetos, caso ocorra uma atualização e percamos o id
    Fill Text    css=input[name=password]    ${user}[password]            #o tipo fica password pra ficar 'escondido'
    
    Click        css=button[type=submit] >> text=Cadastrar        #Seletor css + critério, poderia pesquisar assim tbm//button[text()="Cadastrar"]





   # ======= ANOTAÇÕES ========
    #Checkpoint (end-to-end)
    #Nesse caso, como o site é simples conseguimos mapear tanto por css quanto por xpath
    #Podemos buscar o id por '#', então posso puxar pelo css usando o hashtag antes do nome (id)
    #Para buscar por classe podemos usar o ponto '.', exemplo: .notice
    #Usamos a biblioteca Faker para dados que não são campos chave, para não inflar o db

