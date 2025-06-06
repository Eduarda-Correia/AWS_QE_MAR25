# Automação de Testes da API Serverest

Este projeto contém testes automatizados para a API Serverest (https://compassuol.serverest.dev/) utilizando Robot Framework.

## Estrutura do Projeto

```
|-- tests/
|   |-- usuarios.robot    
|   |-- login.robot       
|   |-- produtos.robot    
|   |-- carrinhos.robot   
|-- resources/
|   |-- keywords.robot    
|   |-- variables.robot   
|-- requirements.txt      
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
- CT18: Usuários: Criar usuário sem senha
- CT19: Usuários: Atualizar usuário com ID inexistente
- CT20: Usuários: Tentar listar usuários sem autenticação

### Login
- CT06: Login com credenciais válidas
- CT07: Login com senha inválida
- CT08: Login após token expirado
- CT21: Login: Login com e-mail inexistente
- CT22: Login: Login com campos obrigatórios ausentes

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

## Observações

- Os testes foram desenvolvidos considerando a documentação oficial da API Serverest
- Alguns casos de teste (CT03, CT04, CT05, CT08) foram marcados como "ISSUE" pois identificam comportamentos da API que não estão de acordo com as regras de negócio esperadas
- As credenciais de administrador são utilizadas para testes que requerem autenticação 
