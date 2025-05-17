# -> Calculadora Python com TDD

Este projeto foi desenvolvido como parte da formação em QA, com foco na aplicação de Test-Driven Development (TDD) em Python utilizando o framework Pytest.

# -> Objetivo

Criar uma classe Calculadora em Python que execute:

- Adição (+)
- Subtração (-)
- Multiplicação (*)
- Divisão (/) com tratamento de erro (divisão por zero)
- Potenciação (**)
- Módulo (%)

Tudo isso acompanhado de testes unitários automatizados com Pytest.

# -> Estrutura do Projeto

SPRINT_5_CALCULADORA/
├── .venv/                    
├── .pytest_cache/            
├── src/
│   └── calculadora.py        
├── tests/
│   └── test_calculadora.py   
├── .gitignore
├── README.md
└── requirements.txt

# -> Ambiente Virtual

Este projeto utiliza um ambiente virtual (.venv) para isolar as dependências, garantindo que as bibliotecas utilizadas não conflitem com outros projetos Python.

# -> Como criar e ativar o ambiente:

Criar o ambiente virtual:
    python -m venv .venv

Ativar no Windows:
    .venv\Scripts\activate

Instalar as dependências:
    pip install -r requirements.txt

# -> Executar os Testes

Para rodar todos os testes do projeto:
    python -m pytest

A saída exibirá pontos (.) para testes bem-sucedidos e letras F se algum teste falhar, junto com os detalhes do erro.

# -> Tecnologias e Ferramentas

- Python 3.13.3
- Pytest
- Ambiente virtual (.venv)
- TDD (Test-Driven Development)

## Referências

- Curso Python Básico para Iniciantes
- Curso Domine Pytest: Testes de Software com Python
- Conteúdo complementar da formação QA
- Suporte de IA com revisão manual (ChatGPT)
- Suporte do meu irmão para dúvidas sobre python