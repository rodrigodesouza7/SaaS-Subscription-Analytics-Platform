CREATE OR REPLACE VIEW vw_active_subscriptions AS
SELECT
    c.company_name,
    p.plan_name,
    p.monthly_price,
    s.start_date
FROM subscriptions s
JOIN customers c
    ON c.customer_id = s.customer_id
JOIN plans p
    ON p.plan_id = s.plan_id
WHERE s.status = 'active';

CREATE OR REPLACE VIEW vw_saas_kpis AS
SELECT
    SUM(p.monthly_price) FILTER (WHERE s.status = 'active') AS mrr,
    SUM(p.monthly_price) FILTER (WHERE s.status = 'active') * 12 AS arr,
    ROUND(
        COUNT(*) FILTER (WHERE s.status = 'canceled')::numeric
        / COUNT(*) * 100,
        2
    ) AS churn_rate_percent,
    COUNT(*) FILTER (WHERE s.status = 'active') AS active_subscriptions,
    COUNT(*) FILTER (WHERE s.status = 'canceled') AS canceled_subscriptions,
    COUNT(*) AS total_subscriptions
FROM subscriptions s
JOIN plans p
    ON p.plan_id = s.plan_id;