*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Resource    ../resources/variables.robot

*** Keywords ***
Criar Reserva Inicial
    Create Session    bookings    ${base_url}
    ${booking_data}=    Create Dictionary
    ...    firstname=Jim
    ...    lastname=Brown
    ...    totalprice=111
    ...    depositpaid=true
    ${dates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${booking_data}    bookingdates=${dates}
    Set To Dictionary    ${booking_data}    additionalneeds=breakfast

    ${response}=    POST On Session    bookings    /booking    json=${booking_data}

    ${response_json}=    Convert To Dictionary    ${response.json()}
    Log    JSON da resposta da criação: ${response_json}

    ${bookingid_raw}=    Get From Dictionary    ${response_json}    bookingid
    Log    Booking ID extraído: ${bookingid_raw}

    # Se bookingid vier como lista (ex: [3838]), extraímos o primeiro elemento
    ${bookingid}=    Run Keyword If    '${bookingid_raw}'[0] == '['    Get From List    ${bookingid_raw}    0
    ...    ELSE    Set Variable    ${bookingid_raw}

    Log    Booking ID final: ${bookingid}
    Set Suite Variable    ${bookingid}

    Log    Booking ID extraído: ${bookingid}
    Set Suite Variable    ${bookingid}

Create Auth Token
    Create Session    auth    ${base_url}
    ${auth_body}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST On Session    auth    /auth    json=${auth_body}
    ${token}=    Get Value From Json    ${response.json()}    token
    [Return]    ${token}