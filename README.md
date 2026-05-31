# SaaS Subscription Analytics Platform

Plataforma de análise de dados para empresas SaaS, cobrindo receita recorrente, retenção de clientes, churn, suporte e engajamento de usuários.

---

## Problema de Negócio

Empresas SaaS dependem diretamente da previsibilidade de receita e retenção de clientes. Sem monitoramento adequado, questões críticas ficam sem resposta:

- Quanto de receita recorrente estamos gerando?
- Quais planos têm melhor desempenho?
- Quais clientes têm risco de cancelamento?
- O suporte influencia no churn?
- Qual o impacto financeiro dos upgrades e downgrades?

Este projeto resolve essas questões através de uma arquitetura de dados completa.

---

## Arquitetura

Producer (Python)
↓
Kafka (saas-events)
↓
PostgreSQL 16 MongoDB 7

customers - user_events
subscriptions - login_events
invoices - audit_logs
payments
support_tickets

---

## Stack

| Tecnologia   | Versão | Função                            |
| ------------ | ------ | --------------------------------- |
| PostgreSQL   | 16     | Banco relacional principal        |
| MongoDB      | 7      | Eventos e logs                    |
| Apache Kafka | 7.6.0  | Ingestão de eventos em tempo real |
| Terraform    | 1.15.5 | Infraestrutura como código        |
| Docker       | —      | Containerização do ambiente       |
| DBeaver      | —      | Administração e queries           |
| Python       | 3.14   | Producer Kafka                    |

---

## Métricas SaaS Implementadas

| Métrica        | Implementação                           |
| -------------- | --------------------------------------- |
| MRR            | `fn_calculate_mrr()` + `vw_saas_kpis`   |
| ARR            | `vw_saas_kpis`                          |
| Churn Rate     | `fn_calculate_churn()` + `vw_saas_kpis` |
| Retenção       | `mv_customer_retention`                 |
| Receita mensal | `mv_monthly_revenue`                    |

---

## SQL Avançado

**Views**

- `vw_active_subscriptions` — assinaturas ativas com plano e cliente
- `vw_saas_kpis` — MRR, ARR, Churn Rate consolidados

**Materialized Views**

- `mv_monthly_revenue` — receita agregada por mês
- `mv_customer_retention` — tempo de vida e status por cliente

**Stored Procedures**

- `sp_create_subscription()` — criação de assinatura
- `sp_upgrade_plan()` — upgrade de plano com validação
- `sp_cancel_subscription()` — cancelamento com data de encerramento

**Functions**

- `fn_calculate_mrr()` — MRR total das assinaturas ativas
- `fn_calculate_churn()` — churn rate percentual
- `fn_customer_monthly_revenue()` — receita mensal por cliente

**Triggers**

- `trg_subscription_status_change` — auditoria automática de mudanças de status

**Transactions**

- Pagamento, upgrade, downgrade e cancelamento com controle transacional explícito

---

## Performance

| Query                          | Antes   | Depois  | Melhoria                        |
| ------------------------------ | ------- | ------- | ------------------------------- |
| Assinaturas ativas por plano   | 0.677ms | 0.669ms | Seq Scan mantido — volume baixo |
| Faturas em atraso              | 1.230ms | 0.697ms | 43%                             |
| Tickets abertos por prioridade | 0.954ms | 0.454ms | 52%                             |

Índices aplicados: `idx_subscriptions_status`, `idx_subscriptions_customer_plan`, `idx_invoices_status`, `idx_invoices_subscription`, `idx_support_tickets_status_priority`, `idx_support_tickets_customer`.

---

## Volume de Dados

| Fonte      | Tabela / Coleção | Registros |
| ---------- | ---------------- | --------- |
| PostgreSQL | customers        | 500       |
| PostgreSQL | subscriptions    | 691       |
| PostgreSQL | invoices         | 3.875     |
| PostgreSQL | payments         | 3.303     |
| PostgreSQL | support_tickets  | 2.000     |
| MongoDB    | user_events      | 4         |
| MongoDB    | login_events     | 50.000    |
| MongoDB    | audit_logs       | 30.000    |
| Kafka      | saas-events      | 1.000     |

---

## Como Executar

**Pré-requisitos**

- Docker Desktop
- Python 3.x
- Terraform

**1. Subir o ambiente**
cd docker
docker compose up -d

**2. Executar o DDL**
Abrir sql/ddl/01_create_tables.sql no DBeaver e executar

**3. Popular os dados**
Executar sql/dml/01_insert_sample_data.sql
Executar sql/dml/02_insert_mass_data.sql

**4. Executar SQL Avançado**
sql/functions/
sql/procedures/
sql/views/
sql/triggers/
sql/transactions/
sql/performance/

**5. Kafka Producer**
python -m venv .venv
source .venv/bin/activate
pip install kafka-python
python3 kafka/01_kafka_events.py

**6. Terraform (opcional)**
cd terraform
terraform init
terraform apply -auto-approve

---

## Estrutura do Repositório

saas-subscription-analytics-platform/
├── docker/
│ └── docker-compose.yml
├── docs/
├── sql/
│ ├── ddl/
│ ├── dml/
│ ├── functions/
│ ├── procedures/
│ ├── triggers/
│ ├── transactions/
│ ├── views/
│ └── performance/
├── mongodb/
│ ├── collections/
│ └── queries/
├── kafka/
├── terraform/
├── diagrams/
└── README.md

---

## Nível do Projeto

**Analista de Banco de Dados Pleno / Data Engineer Júnior Avançado**

---

## Autor

Rodrigo de Souza Silva
[LinkedIn](https://linkedin.com/in/rodrigodesouzasilva) · [GitHub](https://github.com/rodrigodesouza7)
