*** Settings ***
Documentation    Cenários de tentativas de cadastro com senha muito curta

Resource    ../resources/base.resource
Test Template    Short password

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Não deve logar com senha de 1 dígito         1
Não deve cadastrar com senha de 5 dígitos    12345

