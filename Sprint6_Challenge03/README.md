# Automação de Testes da API Serverest

Este projeto contém testes automatizados para a API Serverest (https://serverest.dev/) utilizando Robot Framework.

## Estrutura do Projeto

```
|-- tests/
|   |-- usuarios.robot    # Testes do endpoint /usuarios
|   |-- login.robot       # Testes do endpoint /login
|   |-- produtos.robot    # Testes do endpoint /produtos
|   |-- carrinhos.robot   # Testes do endpoint /carrinhos
|-- resources/
|   |-- keywords.robot    # Keywords customizadas
|   |-- variables.robot   # Variáveis globais
|-- requirements.txt      # Dependências do projeto
```

## Pré-requisitos

- Python 3.7 ou superior
- pip (gerenciador de pacotes Python)

## Instalação

1. Clone o repositório:
```bash
git clone [URL_DO_REPOSITÓRIO]
cd [NOME_DO_DIRETÓRIO]
```

2. Crie e ative um ambiente virtual:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

3. Instale as dependências:
```bash
pip install -r requirements.txt
```

## Executando os Testes

Para executar todos os testes:
```bash
robot tests/
```

Para executar uma suíte específica:
```bash
robot tests/usuarios.robot
robot tests/login.robot
robot tests/produtos.robot
robot tests/carrinhos.robot
```

Para executar um caso de teste específico:
```bash
robot -t "CT01 - Usuários: Criar usuário com dados válidos" tests/usuarios.robot
```

## Relatórios

Após a execução dos testes, os seguintes arquivos serão gerados:
- `log.html`: Log detalhado da execução
- `report.html`: Relatório de execução
- `output.xml`: Arquivo XML com resultados

## Casos de Teste

### Usuários
- CT01: Criar usuário com dados válidos
- CT02: Criar usuário com e-mail já utilizado
- CT03: Criar usuário com e-mail Gmail
- CT04: Criar usuário com senha muito longa
- CT05: Criar usuário com senha muito curta
- CT06: Criar usuário sem senha
- CT07: Atualizar usuário com ID inexistente
- CT08: Atualizar usuário com e-mail já existente
- CT09: Excluir usuário com carrinho

### Login
- CT06: Login com credenciais válidas
- CT07: Login com senha inválida
- CT08: Login após token expirado

### Produtos
- CT09: Criar produto autenticado
- CT10: Criar produto com nome duplicado
- CT11: Tentar excluir produto que já está em carrinho
- CT12: Tentar criar produto sem autenticação
- CT13: Tentar listar produtos sem autenticação
- CT14: Tentar atualizar produto sem autenticação
- CT15: Tentar excluir produto sem autenticação

### Carrinhos
- CT16: Criar carrinho com produtos válidos
- CT17: Criar dois carrinhos com mesmo usuário
- CT18: Tentar criar carrinho sem autenticação
- CT19: Tentar criar carrinho com produto inexistente
- CT20: Tentar criar carrinho com quantidade insuficiente

## Observações

- Os testes foram desenvolvidos considerando a documentação oficial da API Serverest
- Alguns casos de teste (CT03, CT04, CT05, CT08) foram marcados como "ISSUE" pois identificam comportamentos da API que não estão de acordo com as regras de negócio esperadas
- Os testes utilizam dados dinâmicos para evitar conflitos durante a execução
- As credenciais de administrador são utilizadas para testes que requerem autenticação 