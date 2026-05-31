-- =============================================================
-- 02_indexes_and_explain.sql
-- Índices compostos + EXPLAIN ANALYZE antes/depois
-- =============================================================

-- -------------------------------------------------------------
-- 1. ANTES DOS ÍNDICES
-- -------------------------------------------------------------

EXPLAIN ANALYZE
SELECT s.subscription_id, c.company_name, p.plan_name
FROM subscriptions s
JOIN customers c ON c.customer_id = s.customer_id
JOIN plans p     ON p.plan_id = s.plan_id
WHERE s.status = 'active';

EXPLAIN ANALYZE
SELECT i.invoice_id, i.invoice_date, i.amount, c.company_name
FROM invoices i
JOIN subscriptions s ON s.subscription_id = i.subscription_id
JOIN customers c     ON c.customer_id = s.customer_id
WHERE i.status = 'overdue';

EXPLAIN ANALYZE
SELECT customer_id, priority, COUNT(*) AS total
FROM support_tickets
WHERE status = 'Open'
GROUP BY customer_id, priority;


-- -------------------------------------------------------------
-- 2. CRIAÇÃO DOS ÍNDICES NOVOS
-- -------------------------------------------------------------

CREATE INDEX idx_subscriptions_customer_plan
ON subscriptions(customer_id, plan_id);

CREATE INDEX idx_invoices_status
ON invoices(status);

CREATE INDEX idx_invoices_subscription
ON invoices(subscription_id);

CREATE INDEX idx_support_tickets_status_priority
ON support_tickets(status, priority);

CREATE INDEX idx_support_tickets_customer
ON support_tickets(customer_id);


-- -------------------------------------------------------------
-- 3. DEPOIS DOS ÍNDICES
-- -------------------------------------------------------------

EXPLAIN ANALYZE
SELECT s.subscription_id, c.company_name, p.plan_name
FROM subscriptions s
JOIN customers c ON c.customer_id = s.customer_id
JOIN plans p     ON p.plan_id = s.plan_id
WHERE s.status = 'active';

EXPLAIN ANALYZE
SELECT i.invoice_id, i.invoice_date, i.amount, c.company_name
FROM invoices i
JOIN subscriptions s ON s.subscription_id = i.subscription_id
JOIN customers c     ON c.customer_id = s.customer_id
WHERE i.status = 'overdue';

EXPLAIN ANALYZE
SELECT customer_id, priority, COUNT(*) AS total
FROM support_tickets
WHERE status = 'Open'
GROUP BY customer_id, priority;