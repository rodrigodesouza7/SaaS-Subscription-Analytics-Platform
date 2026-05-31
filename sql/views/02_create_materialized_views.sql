-- =============================================================
-- 02_create_materialized_views.sql
-- mv_monthly_revenue e mv_customer_retention
-- =============================================================

CREATE MATERIALIZED VIEW mv_monthly_revenue AS
SELECT
    DATE_TRUNC('month', i.invoice_date)     AS month,
    SUM(i.amount)                           AS total_revenue,
    COUNT(DISTINCT s.customer_id)           AS paying_customers,
    SUM(p.monthly_price)                    AS mrr
FROM invoices i
JOIN subscriptions s ON s.subscription_id = i.subscription_id
JOIN plans p         ON p.plan_id = s.plan_id
WHERE i.status = 'paid'
GROUP BY DATE_TRUNC('month', i.invoice_date)
ORDER BY month;


CREATE MATERIALIZED VIEW mv_customer_retention AS
SELECT
    s.customer_id,
    c.company_name,
    COUNT(s.subscription_id)                AS total_subscriptions,
    SUM(CASE WHEN s.status = 'active'   THEN 1 ELSE 0 END) AS active,
    SUM(CASE WHEN s.status = 'canceled' THEN 1 ELSE 0 END) AS canceled,
    MIN(s.start_date)                       AS first_subscription,
    MAX(s.start_date)                       AS last_subscription,
    CURRENT_DATE - MIN(s.start_date)        AS days_as_customer
FROM subscriptions s
JOIN customers c ON c.customer_id = s.customer_id
GROUP BY s.customer_id, c.company_name
ORDER BY days_as_customer DESC;