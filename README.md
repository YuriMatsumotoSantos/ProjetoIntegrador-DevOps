# Projeto Integrador de DevOps: votação com métricas

[English version below](#english)

Aplicação Flask mínima de votação, instrumentada com métricas para o Prometheus, empacotada com Docker e com build automático no GitLab CI. Trabalho da disciplina de Automação de Software e Infraestrutura (UTFPR).

O objetivo não é a aplicação, que tem três rotas. É o caminho em volta dela: expor métricas, coletar, visualizar e automatizar o build.

## O que tem aqui

| Arquivo | Papel |
|---|---|
| `app.py` | Aplicação Flask. Conta os votos em um `Counter` do Prometheus com o rótulo `opcao` |
| `Dockerfile` | Imagem `python:3.9-slim` com a aplicação |
| `docker-compose.yml` | Sobe a aplicação, o Prometheus e o Grafana na mesma rede |
| `prometheus.yml` | Coleta as métricas da aplicação a cada 5 segundos |
| `.gitlab-ci.yml` | Estágio de build que constrói a imagem Docker a cada push |

## Como rodar

```bash
docker compose up --build
```

| Serviço | Endereço |
|---|---|
| Aplicação | http://localhost:5000 |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 |

## Como usar

1. Vote acessando `http://localhost:5000/votar/a` ou `http://localhost:5000/votar/b`.
2. Veja a métrica bruta em `http://localhost:5000/metrics`, procurando por `app_votos_total`.
3. No Prometheus, consulte `app_votos_total` para ver os votos por opção.
4. No Grafana, adicione o Prometheus como fonte de dados, com o endereço `http://prometheus:9090`, e monte um painel com a mesma consulta.

Qualquer opção diferente de `a` ou `b` devolve erro 400 e não é contada.

## Limites

- Os votos ficam só na memória. Reiniciar o contêiner zera a contagem.
- Não há autenticação nem controle de voto repetido.
- O pipeline só constrói a imagem. Não roda testes nem publica.
- O Grafana sobe sem painel configurado.

---

## English

A minimal Flask voting application, instrumented with Prometheus metrics, packaged with Docker and built automatically on GitLab CI. Coursework for the Software and Infrastructure Automation class at UTFPR.

The point is not the application, which has three routes. It is the path around it: exposing metrics, collecting them, visualizing them and automating the build.

### What is in here

| File | Role |
|---|---|
| `app.py` | Flask application. Counts votes in a Prometheus `Counter` labeled by `opcao` |
| `Dockerfile` | `python:3.9-slim` image with the application |
| `docker-compose.yml` | Starts the application, Prometheus and Grafana on the same network |
| `prometheus.yml` | Scrapes the application metrics every 5 seconds |
| `.gitlab-ci.yml` | Build stage that builds the Docker image on every push |

### How to run

```bash
docker compose up --build
```

| Service | Address |
|---|---|
| Application | http://localhost:5000 |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 |

### How to use

1. Vote by opening `http://localhost:5000/votar/a` or `http://localhost:5000/votar/b`.
2. See the raw metric at `http://localhost:5000/metrics`, looking for `app_votos_total`.
3. In Prometheus, query `app_votos_total` to see the votes per option.
4. In Grafana, add Prometheus as a data source at `http://prometheus:9090` and build a panel with the same query.

Any option other than `a` or `b` returns a 400 error and is not counted.

### Limits

- Votes live in memory only. Restarting the container resets the count.
- There is no authentication and no protection against repeated votes.
- The pipeline only builds the image. It does not run tests or publish.
- Grafana starts with no dashboard configured.
