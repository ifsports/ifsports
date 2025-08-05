# Manual do Ambiente

Este manual irá guiá-lo na inicialização do ambiente de microserviços, do frontend e dos serviços de backup e monitoramento do IFSports.

-----

## Inicializando o Ambiente

### Configuração Inicial

#### 1.  **Clone o Repositório Principal (`ifsports`)**: Este é o repositório geral que contém a estrutura do projeto e os arquivos de configuração do Docker.

    bash

    git clone [URL_DO_REPOSITORIO_IFSPORTS]
    cd ifsports
    

#### 2.  **Clone os Repositórios dos Microserviços**: O projeto utiliza microserviços separados. Dentro da pasta `ifsports`, você precisará clonar cada repositório de serviço na sua respectiva pasta.

    bash

    git clone [URL_DO_REPOSITORIO_FRONTEND]
    git clone [URL_DO_REPOSITORIO_COMPETITIONS]
    git clone [URL_DO_REPOSITORIO_MATCH_COMMENTS]
    git clone [URL_DO_REPOSITORIO_AUTH_SERVICE]
    git clone [URL_DO_REPOSITORIO_AUDIT]
    git clone [URL_DO_REPOSITORIO_TEAMS]
    git clone [URL_DO_REPOSITORIO_REQUESTS]
    git clone [URL_DO_REPOSITORIO_CALENDAR]
    

#### 3.  **Configurar Variáveis de Ambiente**: O repositório principal contém arquivos `env-example` que precisam ser copiados e preenchidos.

      * Crie um arquivo `jwt.env` a partir do `jwt.env-example`.
      * Altere a pasta `envs-exemple` para `envs` , altere os arquivos `[nome_do_servico].env-example` para `[nome_do_servico].env`.
      * Preencha as variáveis de ambiente com os valores correspondentes.

-----

## Rodando o Projeto

### Com Docker Compose

Para rodar o sistema de microserviços completo (incluindo o Kong Gateway e bancos de dados dos serviços), navegue até a pasta `ifsports` e use o arquivo `docker-compose.yml`.

#### 1.  **Construa as Imagens e Inicie os Contêineres**: O comando `--build` garantirá que todas as imagens sejam criadas.

    bash

    docker-compose up -d --build
    

#### 2.  **Verifique o Status**: Você pode verificar o status de todos os contêineres com o seguinte comando:

    bash

    docker-compose ps
    

-----

## Serviços Adicionais (Monitoramento e Backup)

O projeto pode incluir funcionalidades adicionais, como backup automático e monitoramento.

### Backup de Bancos de Dados

O arquivo `docker-compose.backup.yml` é usado para gerenciar backups de bancos de dados. Ele pode ser iniciado separadamente do seu ambiente principal.

bash

docker-compose -f docker-compose.backup.yml up -d


### Monitoramento (Prometheus e Grafana)

Para monitorar a saúde dos serviços, você pode usar uma stack de monitoramento. Isso envolveria adicionar os serviços `prometheus` e `grafana` ao seu `docker-compose.yml` principal ou em um arquivo separado.

  * **Acesse o Grafana**: Uma vez que os contêineres do Grafana e Prometheus estejam rodando, o Grafana estará acessível em `http://localhost:3001` (se a porta 3001 foi mapeada no `docker-compose.yml`).
  * **Adicione o Prometheus**: No painel do Grafana, adicione o Prometheus como uma fonte de dados para criar painéis de visualização das métricas de CPU, memória, latência, etc. dos seus microserviços.

-----

### Configurando o Ambiente do Frontend

O frontend da aplicação está no repositório `frontend-ifsports` e é uma aplicação Next.js.

#### 1.  **Instale as Dependências**: Na pasta `frontend-ifsports`, abra um terminal e execute o comando abaixo para instalar todas as dependências do projeto.

    bash

    npm install
    

#### 2.  **Variáveis de Ambiente**: Para que o frontend se comunique com os microserviços através do Kong Gateway, você precisa configurar as variáveis de ambiente em um arquivo `.env.local`.

      * `NEXT_PUBLIC_API_BASE_URL`: A URL base das suas APIs, que deve apontar para a sua máquina local (`http://localhost`) para se comunicar com o Kong, ou para a sua VM na nuvem (ex: `http://[IP_EXTERNO]:80`).

#### 3.  **Inicie o Frontend**: Inicie a aplicação em modo de desenvolvimento com o seguinte comando.

    bash

    npm run dev
    
