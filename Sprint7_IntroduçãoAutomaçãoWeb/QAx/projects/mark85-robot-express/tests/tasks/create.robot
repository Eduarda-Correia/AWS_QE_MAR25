*** Settings ***
Documentation    Cenários de cadastro de tarefas

Resource    ../../resources/base.resource

Test Setup    Start Session            #todo inicio de teste
Test Teardown    Take Screenshot       #todo fim de teste

*** Test Cases ***
CT01 - Deve poder Cadastrar uma nova tarefas
    [Tags]    POSITIVO

    ${data}    Get fixture    tasks    create

    Clean user from database        ${data}[user][email]
    Insert user from database       ${data}[user]

    Submit login form               ${data}[user]
    User should be logged in        ${data}[user][name]

    Go to task form
    Submit task form                ${data}[tasks]
    Task should be registered       ${data}[tasks][name]

CT02 - Não deve cadastrar tarefa com nome duplicado
    [Tags]    NEGATIVO    dup 

    ${data}    Get fixture    tasks    duplicate

    Clean user from database        ${data}[user][email]
    Insert user from database       ${data}[user]

    POST user Session    ${data}[user]
    POST a nem Task    ${data}[tasks]

    Submit login form               ${data}[user]
    User should be logged in        ${data}[user][name]

    Go to task form
    Submit task form                ${data}[tasks]

    Notice should be    Oops! Tarefa duplicada.