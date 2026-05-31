-- =============================================================
-- 02_create_procedures.sql
-- sp_create_subscription() e sp_upgrade_plan()
-- =============================================================

CREATE OR REPLACE PROCEDURE sp_create_subscription(
    p_customer_id INT,
    p_plan_id     INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO subscriptions (customer_id, plan_id, start_date, status)
    VALUES (p_customer_id, p_plan_id, CURRENT_DATE, 'active');
END;
$$;


CREATE OR REPLACE PROCEDURE sp_upgrade_plan(
    p_subscription_id INT,
    p_new_plan_id     INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE subscriptions
       SET plan_id = p_new_plan_id
     WHERE subscription_id = p_subscription_id
       AND status = 'active';

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Subscription % not found or not active', p_subscription_id;
    END IF;
END;
$$;