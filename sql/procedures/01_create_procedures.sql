CREATE OR REPLACE PROCEDURE sp_cancel_subscription(
    p_subscription_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE subscriptions
       SET status = 'canceled',
           end_date = CURRENT_DATE
     WHERE subscription_id = p_subscription_id;
END;
$$;