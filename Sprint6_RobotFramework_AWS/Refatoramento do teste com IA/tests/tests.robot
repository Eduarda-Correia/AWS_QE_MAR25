*** Settings ***
Documentation    Arquivo simples para requisições em HTTP em APIs restful-booker
Library    RequestsLibrary
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot
Resource    ../resources/keywords.robot

*** Test Cases ***
Cenário 01: POST - Autenticação com credenciais válidas
    Criar Sessão
    Realizar Login como administrador
    Validar Status Code    200
    Verificar se foi gerado um token

Cenário 02: GET - Buscar todas as reservas
    Criar Sessão
    Buscar Lista de Reservas
    Validar Status Code    200
    Verificar se retornou lista de reservas

Cenário 03: POST - Criar nova reserva
    Criar Sessão
    Criar Nova Reserva
    Validar Status Code    200
    Verificar dados da reserva criada

Cenário 04: GET - Buscar reserva específica
    Criar Sessão
    ${booking_id}=    Criar Nova Reserva
    Buscar Reserva por ID    ${booking_id}
    Validar Status Code    200
    Verificar detalhes da reserva

Cenário 05: PUT - Atualizar reserva existente
    Criar Sessão
    ${token}=    Realizar Login como administrador e retornar token
    ${booking_id}=    Criar Nova Reserva
    Atualizar Reserva    ${booking_id}    ${token}
    Validar Status Code    200
    Verificar dados da reserva atualizada

Cenário 06: DELETE - Excluir reserva
    Criar Sessão
    ${token}=    Realizar Login como administrador e retornar token
    ${booking_id}=    Criar Nova Reserva
    Deletar Reserva    ${booking_id}    ${token}
    Validar Status Code    201

