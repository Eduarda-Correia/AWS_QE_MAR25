*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Resource          ../resources/variables.robot
Resource          ../resources/keywords.robot
Suite Setup        Criar Reserva Inicial

*** Test Cases ***
Cenário 1: obter todos os ids de reservas 
    Create Session    bookings    ${base_url}
    ${response}=    GET On Session    bookings    /booking
    Status Should Be    200    ${response}

Cenário 2: criar nova reserva
    Create Session    bookings    ${base_url}
    ${booking_data}=    Create Dictionary
    ...    firstname=Jim
    ...    lastname=Brown
    ...    totalprice=111
    ...    depositpaid=true
    ...    bookingdates=${None}
    ...    additionalneeds=breakfast
    ${dates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${booking_data}    bookingdates=${dates}
    
    ${response}=    POST On Session    bookings    /booking    json=${booking_data}
    Status Should Be    200    ${response}

    ${bookingid}=    Get Value From Json    ${response.json()}    bookingid
    Set Suite Variable    ${bookingid}     

Cenário 3: atualizar reserva com token
    ${token}=    Create Auth Token
    Log    Token gerado: ${token}

    ${cookie}=    Set Variable    token=${token}
    ${headers}=   Create Dictionary    Cookie=${cookie}
    Create Session    update    ${base_url}    headers=${headers}

    ${dates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01

    ${update_data}=    Create Dictionary
    ...    firstname=james
    ...    lastname=brown
    ...    totalprice=111
    ...    depositpaid=true
    ...    bookingdates=${dates}
    ...    additionalneeds=breakfast

    Log    Booking ID sendo usado: ${bookingid}
    Log    Dados para atualização: ${update_data}

    ${response}=    PUT On Session    update    /booking/${bookingid}    json=${update_data}
    Status Should Be    200    ${response}
    Log    Resposta da atualização: ${response.text}