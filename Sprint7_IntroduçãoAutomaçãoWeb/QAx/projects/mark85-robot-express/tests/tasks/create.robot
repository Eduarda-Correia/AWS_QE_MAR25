*** Settings ***
Documentation    Cenários de cadastro de tarefas

Resource    ../../resources/base.resource

Test Setup    Start Session            #todo inicio de teste
Test Teardown    Take Screenshot       #todo fim de teste

*** Test Cases ***
CT01 - Deve poder Cadastrar uma nova tarefas
    [Tags]    POSITIVO

    ${data}    Get fixture    tasks    create

    Reset user from database        ${data}[user]

    Do login                        ${data}[user]

    Go to task form
    Submit task form                ${data}[tasks]
    Task should be registered       ${data}[tasks][name]

CT02 - Não deve cadastrar tarefa com nome duplicado
    [Tags]    NEGATIVO    dup 

    ${data}    Get fixture    tasks    duplicate

    Reset user from database       ${data}[user]
    Create a new task from API     ${data}    
    
    Do login                       ${data}[user]

    Go to task form
    Submit task form               ${data}[tasks]

    Notice should be    Oops! Tarefa duplicada.

CT03 - Não deve cadastrar uma nova tarefa quando atinge o limite de Tags
    [Tags]    NEGATIVO    tags_max

    ${data}    Get fixture    tasks    tags_limit

    Reset user from database        ${data}[user]
    Create a new task from API      ${data}    

    Do login                        ${data}[user]

    Go to task form
    Submit task form                ${data}[tasks]

    Notice should be    Oops! Limite de tags atingido.