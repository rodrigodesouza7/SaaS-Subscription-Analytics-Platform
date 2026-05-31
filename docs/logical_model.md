# Modelo Lógico

## Banco Relacional — PostgreSQL

### customers

| Coluna       | Tipo         | Restrição                 |
| ------------ | ------------ | ------------------------- |
| customer_id  | SERIAL       | PRIMARY KEY               |
| company_name | VARCHAR(200) | NOT NULL                  |
| contact_name | VARCHAR(150) | —                         |
| email        | VARCHAR(255) | UNIQUE                    |
| country      | VARCHAR(100) | —                         |
| created_at   | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP |

### plans

| Coluna        | Tipo          | Restrição   |
| ------------- | ------------- | ----------- |
| plan_id       | SERIAL        | PRIMARY KEY |
| plan_name     | VARCHAR(100)  | NOT NULL    |
| monthly_price | NUMERIC(10,2) | NOT NULL    |
| yearly_price  | NUMERIC(10,2) | —           |

### subscriptions

| Coluna          | Tipo        | Restrição      |
| --------------- | ----------- | -------------- |
| subscription_id | SERIAL      | PRIMARY KEY    |
| customer_id     | INT         | FK → customers |
| plan_id         | INT         | FK → plans     |
| start_date      | DATE        | NOT NULL       |
| end_date        | DATE        | —              |
| status          | VARCHAR(30) | NOT NULL       |

### invoices

| Coluna          | Tipo          | Restrição          |
| --------------- | ------------- | ------------------ |
| invoice_id      | SERIAL        | PRIMARY KEY        |
| subscription_id | INT           | FK → subscriptions |
| invoice_date    | DATE          | NOT NULL           |
| amount          | NUMERIC(10,2) | NOT NULL           |
| status          | VARCHAR(30)   | NOT NULL           |

### payments

| Coluna         | Tipo          | Restrição     |
| -------------- | ------------- | ------------- |
| payment_id     | SERIAL        | PRIMARY KEY   |
| invoice_id     | INT           | FK → invoices |
| payment_date   | DATE          | NOT NULL      |
| amount         | NUMERIC(10,2) | NOT NULL      |
| payment_method | VARCHAR(50)   | —             |

### support_tickets

| Coluna      | Tipo         | Restrição                 |
| ----------- | ------------ | ------------------------- |
| ticket_id   | SERIAL       | PRIMARY KEY               |
| customer_id | INT          | FK → customers            |
| opened_at   | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP |
| priority    | VARCHAR(20)  | —                         |
| status      | VARCHAR(20)  | —                         |
| subject     | VARCHAR(255) | —                         |

### subscription_audit

| Coluna          | Tipo        | Restrição                 |
| --------------- | ----------- | ------------------------- |
| audit_id        | SERIAL      | PRIMARY KEY               |
| subscription_id | INT         | NOT NULL                  |
| old_status      | VARCHAR(30) | —                         |
| new_status      | VARCHAR(30) | —                         |
| changed_at      | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP |

---

## Índices

| Índice                              | Tabela          | Colunas              |
| ----------------------------------- | --------------- | -------------------- |
| idx_subscriptions_status            | subscriptions   | status               |
| idx_subscriptions_customer_plan     | subscriptions   | customer_id, plan_id |
| idx_invoices_status                 | invoices        | status               |
| idx_invoices_subscription           | invoices        | subscription_id      |
| idx_support_tickets_status_priority | support_tickets | status, priority     |
| idx_support_tickets_customer        | support_tickets | customer_id          |

---

## Banco Documental — MongoDB

### user_events

```json
{
  "customer_id": 1,
  "event_type": "feature_usage",
  "event_date": "2026-05-31T00:00:00Z"
}
```

### login_events

```json
{
  "customer_id": 1,
  "device": "desktop",
  "location": "SP",
  "status": "success",
  "timestamp": "2026-05-31T00:00:00Z"
}
```

### audit_logs

```json
{
  "entity": "subscription",
  "entity_id": 10,
  "action": "upgraded",
  "customer_id": 1,
  "timestamp": "2026-05-31T00:00:00Z"
}
```

---

## Kafka

### Tópico: saas-events

```json
{
  "event_type": "PLAN_UPGRADED",
  "customer_id": 42,
  "plan_id": 3,
  "amount": 199.9,
  "timestamp": "2026-05-31T00:00:00Z"
}
```

**Eventos disponíveis:**

- USER_SIGNED_UP
- SUBSCRIPTION_STARTED
- PLAN_UPGRADED
- PLAN_DOWNGRADED
- PAYMENT_FAILED
- FEATURE_USED
- SUBSCRIPTION_CANCELLED
