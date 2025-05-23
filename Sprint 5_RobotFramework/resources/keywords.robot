*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource    ../resources/variables.robot

*** Keywords ***
Create Auth Token
    Create Session    auth    ${base_url}
    ${body}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    Post Request    auth    /auth    json=${body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Get Value From Json    ${response.json()}    token
    [Return]    ${token}