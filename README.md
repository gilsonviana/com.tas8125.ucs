# com.tas8125.ucs

Aplicação web com frontend em **React + TypeScript**, backend em **PHP puro** e banco de dados **MySQL**, totalmente orquestrada via Docker.

---

## Estrutura do Projeto

```
.
├── docker-compose.yml          # Orquestra os três serviços
├── frontend/                   # Aplicação React 18 + TypeScript
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── index.tsx           # Ponto de entrada do React
│   │   ├── App.tsx             # Componente raiz – busca /vagas da API
│   │   ├── App.css
│   │   ├── index.css
│   │   ├── react-app-env.d.ts  # Declarações de tipo do CRA
│   │   └── components/        # Coloque seus componentes reutilizáveis aqui
│   ├── tsconfig.json
│   └── package.json
├── backend/                    # API REST em PHP 8.2
│   ├── Dockerfile
│   ├── public/
│   │   ├── index.php           # CORS, autoloader e roteador
│   │   └── .htaccess           # Regras de reescrita do Apache
│   └── src/
│       ├── Config/
│       │   └── Database.php    # Conexão PDO (singleton)
│       ├── Controllers/
│       │   ├── UsuarioController.php
│       │   └── VagaController.php
│       └── Models/
│           ├── UsuarioModel.php
│           └── VagaModel.php
└── database/
    ├── schema.sql              # Criação das tabelas
    └── seed.sql                # Dados de exemplo
```

---

## Pré-requisitos

Antes de começar, instale:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (inclui o Docker Compose)

> Nenhuma outra instalação é necessária. Node.js e PHP rodam dentro dos contêineres.

---

## Como Executar

### 1. Clone o repositório

```bash
git clone <url-do-repositorio>
cd com.tas8125.ucs
```

### 2. Configure as variáveis de ambiente

```bash
cp frontend/.env.example frontend/.env
cp backend/.env.example  backend/.env
```

> Os arquivos `.env` já vêm com valores padrão para desenvolvimento local. Não é necessário editar nada para rodar pela primeira vez.

### 3. Suba os serviços

```bash
docker compose up --build
```

Na primeira execução o Docker vai baixar as imagens e instalar as dependências — isso pode demorar alguns minutos.

Quando aparecer `Compiled successfully` no terminal, acesse:

| Serviço  | Endereço               |
|----------|------------------------|
| Frontend | http://localhost:3000  |
| Backend  | http://localhost:8080  |
| MySQL    | localhost:3306         |

### 4. Parar os serviços

```bash
docker compose down        # mantém os dados do banco
docker compose down -v     # apaga também os dados do banco
```

---

## Endpoints da API

URL base: `http://localhost:8080`

| Método | Caminho          | Descrição               |
|--------|------------------|-------------------------|
| GET    | /usuarios        | Lista todos os usuários |
| GET    | /usuarios/{id}   | Busca um usuário        |
| GET    | /vagas           | Lista todas as vagas    |
| GET    | /vagas/{id}      | Busca uma vaga          |

### Exemplo

```bash
# Listar todas as vagas
curl http://localhost:8080/vagas

# Buscar uma vaga específica
curl http://localhost:8080/vagas/1
```

---

## Notas de Desenvolvimento

- **Adicionando um novo recurso** — crie um novo Controller em `backend/src/Controllers/` e um Model em `backend/src/Models/`, depois registre as rotas em `backend/public/index.php`.
- **Variáveis de ambiente do frontend** — todas as variáveis `REACT_APP_*` em `frontend/.env` são injetadas em tempo de build pelo Create React App.
- **TypeScript** — o frontend usa TypeScript 4.x (compatível com `react-scripts` 5). Os tipos ficam definidos junto ao componente que os usa, em `App.tsx`.
- **CORS** — o `Access-Control-Allow-Origin: *` em `index.php` é adequado para desenvolvimento local. Em produção, substitua pelo domínio real do frontend.
- **Banco de dados** — se precisar recriar o banco do zero (ex: após alterar `schema.sql` ou `seed.sql`), rode `docker compose down -v && docker compose up`.
