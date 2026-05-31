CREATE OR REPLACE FUNCTION fn_customer_monthly_revenue(
    p_customer_id INT
)
RETURNS NUMERIC
AS $$
DECLARE
    v_revenue NUMERIC;
BEGIN
    SELECT SUM(pl.monthly_price)
    INTO v_revenue
    FROM subscriptions s
    JOIN plans pl
        ON pl.plan_id = s.plan_id
    WHERE s.customer_id = p_customer_id
      AND s.status = 'active';

    RETURN COALESCE(v_revenue, 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_log_subscription_status_change()
RETURNS TRIGGER
AS $$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO subscription_audit (
            subscription_id,
            old_status,
            new_status
        )
        VALUES (
            NEW.subscription_id,
            OLD.status,
            NEW.status
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;