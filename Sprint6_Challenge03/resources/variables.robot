*** Variables ***
# URLs e Endpoints
${base_url}    https://compassuol.serverest.dev/
${endpoint_usuarios}    /usuarios
${endpoint_login}    /login
${endpoint_produtos}    /produtos
${endpoint_carrinhos}    /carrinhos

# Status Codes
${status_ok}    200
${status_created}    201
${status_bad_request}    400
${status_unauthorized}    401
${status_forbidden}    403
${status_not_found}    404

# Mensagens de Erro
${msg_email_ja_cadastrado}    Este email já está sendo usado
${msg_email_invalido}    email deve ser um email válido
${msg_senha_longa}    password deve ter entre 5 e 10 caracteres
${msg_senha_curta}    password deve ter entre 5 e 10 caracteres
${msg_senha_obrigatoria}    password é obrigatório
${msg_token_invalido}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais
${msg_produto_nao_encontrado}    Produto não encontrado
${msg_quantidade_insuficiente}    Produto não possui quantidade suficiente
${msg_carrinho_duplicado}    Não é permitido ter mais de 1 carrinho
${msg_usuario_carrinho}    Não é permitido excluir usuário com carrinho cadastrado
${msg_carrinho_nao_encontrado}    Não foi encontrado carrinho para esse usuário

# Credenciais de Teste
${admin_email}    fulano@qa.com
${admin_senha}    teste

# Payloads de exemplo
${payload_usuario_valido}    {"nome": "Fulano da Silva", "email": "fulano@qa.com", "password": "teste", "administrador": "true"}
${payload_produto_valido}    {"nome": "Produto Teste", "preco": 100, "descricao": "Descrição do produto teste", "quantidade": 10}
${payload_carrinho_valido}    {"produtos": [{"idProduto": "123", "quantidade": 1}]}

# Headers
${headers_content_type}    &{EMPTY}
${EMPTY_LIST}    @{EMPTY}
${auth_token}    ${None}