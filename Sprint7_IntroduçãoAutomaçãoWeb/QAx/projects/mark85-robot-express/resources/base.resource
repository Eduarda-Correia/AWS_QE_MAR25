*** Settings ***

Library    libs/database.py
Library    Browser
Library    JSONLibrary

Resource    env.resource

Resource    pages/Components/Header.resource
Resource    pages/Components/Notice.resource
Resource    pages/Components/Alert.resource

Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TasksPage.resource

Resource    services.resource

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=${False}
    New Page       ${BASE_URL}

Short password        #template
    [Arguments]    ${short_pass}

        ${user}    Create Dictionary
    ...        name=Maria
    ...        email=mariateste@gmail.com
    ...        password=${short_pass}
        
    Go to signup Page
    Submit signup form    ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos

#Helpers
Get fixture
    [Arguments]    ${file_naame}    ${cenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/${file_naame}.json
    ...    encoding= utf-8  

    [Return]    ${data}[${cenario}]

Reset user from database
    [Arguments]    ${user}    

    Clean user from database        ${user}[email]
    Insert user from database       ${user}

Create a new task from API
    [Arguments]    ${data}

    POST user Session            ${data}[user]
    POST a nem task              ${data}[tasks]

Do login
    [Arguments]    ${user}

    Submit login form               ${user}
    User should be logged in        ${user}[name]