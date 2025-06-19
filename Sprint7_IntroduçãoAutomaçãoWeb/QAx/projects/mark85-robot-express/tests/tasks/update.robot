*** Settings ***
Documentation    Cenários de testes de atualização de tarefas

Resource    ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot
Library    FakerLibrary

*** Test Cases ***
Deve poder marcar uma tarefa como concluída
    [Tags]    POSITIVO

    ${data}    Get fixture    tasks    done

    Reset user from database      ${data}[user]
    Create a new task from API    ${data}    

    Do login                      ${data}[user]

    Mark task as completed        ${data}[tasks][name]
    Task should be completed      ${data}[tasks][name]

    Sleep    5
