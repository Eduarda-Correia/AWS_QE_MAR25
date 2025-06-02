*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    ../resources/variables.robot

*** Keywords ***
Criar Sessão
    Create Session    restful-booker    ${URL_BASE}    verify=True

Realizar Login como administrador
    ${payload}=    Create Dictionary    username=${USUARIO}    password=${SENHA}
    ${response}=    POST On Session    restful-booker    /auth    json=${payload}
    Set Suite Variable    ${response}

Realizar Login como administrador e retornar token
    Realizar Login como administrador
    ${body}=    Set Variable    ${response.json()}
    [Return]    ${body}[token]

Validar Status Code
    [Arguments]    ${statuscode}
    Should Be Equal As Numbers    ${response.status_code}    ${statuscode}

Verificar se foi gerado um token
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    token

Buscar Lista de Reservas
    ${response}=    GET On Session    restful-booker    /booking
    Set Suite Variable    ${response}

Verificar se retornou lista de reservas
    ${body}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${body}

Criar Nova Reserva
    ${bookingdates}=    Create Dictionary    checkin=${CHECKIN}    checkout=${CHECKOUT}
    ${payload}=    Create Dictionary
    ...    firstname=${NOME}
    ...    lastname=${SOBRENOME}
    ...    totalprice=${PRECO}
    ...    depositpaid=true
    ...    bookingdates=${bookingdates}
    
    ${response}=    POST On Session    restful-booker    /booking    json=${payload}
    Set Suite Variable    ${response}
    ${body}=    Set Variable    ${response.json()}
    [Return]    ${body}[bookingid]

Verificar dados da reserva criada
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    bookingid
    Dictionary Should Contain Key    ${body}    booking

Buscar Reserva por ID
    [Arguments]    ${booking_id}
    ${response}=    GET On Session    restful-booker    /booking/${booking_id}
    Set Suite Variable    ${response}

Verificar detalhes da reserva
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    firstname
    Dictionary Should Contain Key    ${body}    lastname
    Dictionary Should Contain Key    ${body}    totalprice
    Dictionary Should Contain Key    ${body}    bookingdates

Atualizar Reserva
    [Arguments]    ${booking_id}    ${token}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${bookingdates}=    Create Dictionary    checkin=${CHECKIN}    checkout=${CHECKOUT}
    ${payload}=    Create Dictionary
    ...    firstname=Maria
    ...    lastname=Santos
    ...    totalprice=200
    ...    depositpaid=true
    ...    bookingdates=${bookingdates}
    
    ${response}=    PUT On Session    restful-booker    /booking/${booking_id}    json=${payload}    headers=${headers}
    Set Suite Variable    ${response}

Verificar dados da reserva atualizada
    ${body}=    Set Variable    ${response.json()}
    Should Be Equal    ${body}[firstname]    Maria
    Should Be Equal    ${body}[lastname]    Santos
    Should Be Equal As Numbers    ${body}[totalprice]    200

Deletar Reserva
    [Arguments]    ${booking_id}    ${token}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE On Session    restful-booker    /booking/${booking_id}    headers=${headers}
    Set Suite Variable    ${response} 