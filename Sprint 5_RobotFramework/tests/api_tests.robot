*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem
Resource          ../resources/variables.robot
Resource          ../resources/keywords.robot

*** Test Cases ***
Cenário 1: obter todos os ids de reservas
    ${base_url}=    Set Variable    
    Create Session    bookings    ${base_url}
    ${response}=    Get Request    bookings    /booking
    Status Should Be    200    ${response}

Cenário 2: criar nova reserva
    Create Session    bookings    ${base_url}
    ${booking_data}=    Create Dictionary
    ...    firstname=jim
    ...    lastname=brown
    ...    totalprice=111
    ...    depositpaid=true
    ...    bookingdates=${None}
    ...    additionalneeds=breakfast
    ${dates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${booking_data}    bookingdates=${dates}
    ${response}=    Post Request    bookings    /booking    json=${booking_data}
    Status Should Be    200    ${response}
    ${booking_id}=    Get Value From Json    ${response.json()}    bookingid

Cenário 3: atualizar reserva com token
    ${token}=    Create Auth Token
    Create Session    update    ${base_url}    headers=Cookie=token=${token}
    ${update_data}=    Create Dictionary
    ...    firstname=james
    ...    lastname=brown
    ...    totalprice=111
    ...    depositpaid=true
    ...    bookingdates=${None}
    ...    additionalneeds=breakfast
    ${dates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${update_data}    bookingdates=${dates}
    ${response}=    Put Request    update    /booking/1    json=${update_data}
    Status Should Be    200    ${response}