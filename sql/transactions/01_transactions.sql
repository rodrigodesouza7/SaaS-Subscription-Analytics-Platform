-- =============================================================
-- 01_transactions.sql
-- Transactions explícitas para operações críticas
-- =============================================================

-- -------------------------------------------------------------
-- 1. PAGAMENTO
-- -------------------------------------------------------------
BEGIN;

    INSERT INTO payments (invoice_id, payment_date, amount, payment_method)
    SELECT
        i.invoice_id,
        CURRENT_DATE,
        i.amount,
        'PIX'
    FROM invoices i
    WHERE i.invoice_id = 1
      AND i.status = 'pending';

    UPDATE invoices
       SET status = 'paid'
     WHERE invoice_id = 1;

COMMIT;


-- -------------------------------------------------------------
-- 2. UPGRADE DE PLANO
-- -------------------------------------------------------------
BEGIN;

    UPDATE subscriptions
       SET plan_id = 4
     WHERE subscription_id = 2
       AND status = 'active';

    INSERT INTO subscription_audit (subscription_id, old_status, new_status)
    VALUES (2, 'active', 'active');

COMMIT;


-- -------------------------------------------------------------
-- 3. DOWNGRADE DE PLANO
-- -------------------------------------------------------------
BEGIN;

    UPDATE subscriptions
       SET plan_id = 1
     WHERE subscription_id = 3
       AND status = 'active';

    INSERT INTO subscription_audit (subscription_id, old_status, new_status)
    VALUES (3, 'active', 'active');

COMMIT;


-- -------------------------------------------------------------
-- 4. CANCELAMENTO
-- -------------------------------------------------------------
BEGIN;

    UPDATE subscriptions
       SET status   = 'canceled',
           end_date = CURRENT_DATE
     WHERE subscription_id = 4
       AND status = 'active';

    INSERT INTO subscription_audit (subscription_id, old_status, new_status)
    VALUES (4, 'active', 'canceled');

COMMIT;