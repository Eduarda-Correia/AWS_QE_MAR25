# Testes Automatizados para API Restful-Booker com Robot Framework

Este projeto tem como objetivo automatizar os testes das principais funcionalidades da API [restful-booker](https://restful-booker.herokuapp.com), cobrindo operações CRUD (Create, Read, Update, Delete) e autenticação, utilizando o Robot Framework.

## Funcionalidades Testadas

Os seguintes cenários foram implementados:

- Autenticação de usuário
- Busca de todas as reservas
- Criação de nova reserva
- Busca de reserva específica por ID
- Atualização de reserva existente
- Exclusão de reserva

## Tecnologias Utilizadas

- [Robot Framework](https://robotframework.org/)
- [RequestsLibrary](https://github.com/MarketSquare/RequestsLibrary) (para interações HTTP com a API)

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

- `tests/`: Casos de teste
- `resources/`: Arquivos com keywords e variáveis
  - `keywords.robot`: Keywords reutilizáveis para login, criação de reservas, etc.
  - `variables.robot`: Variáveis comuns como URL base, credenciais e dados de reserva

## Nota Pessoal

No início, o aprendizado com o Robot Framework foi pouco explorado, mas esta entrega reflete uma evolução na organização do código, com a separação de responsabilidades em arquivos de keywords e variáveis, visando maior clareza e manutenibilidade.
