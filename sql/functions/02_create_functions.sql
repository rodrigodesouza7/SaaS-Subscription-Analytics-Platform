-- =============================================================
-- 02_create_functions.sql
-- fn_calculate_mrr() e fn_calculate_churn()
-- =============================================================

CREATE OR REPLACE FUNCTION fn_calculate_mrr()
RETURNS NUMERIC
AS $$
DECLARE
    v_mrr NUMERIC;
BEGIN
    SELECT SUM(p.monthly_price)
    INTO v_mrr
    FROM subscriptions s
    JOIN plans p ON p.plan_id = s.plan_id
    WHERE s.status = 'active';

    RETURN COALESCE(v_mrr, 0);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_calculate_churn()
RETURNS NUMERIC
AS $$
DECLARE
    v_total      NUMERIC;
    v_canceled   NUMERIC;
    v_churn_rate NUMERIC;
BEGIN
    SELECT COUNT(*) INTO v_total    FROM subscriptions;
    SELECT COUNT(*) INTO v_canceled FROM subscriptions WHERE status = 'canceled';

    IF v_total = 0 THEN
        RETURN 0;
    END IF;

    v_churn_rate := ROUND((v_canceled / v_total) * 100, 2);

    RETURN v_churn_rate;
END;
$$ LANGUAGE plpgsql;