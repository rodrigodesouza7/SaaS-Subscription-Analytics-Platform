CREATE TRIGGER trg_subscription_status_change
AFTER UPDATE ON subscriptions
FOR EACH ROW
EXECUTE FUNCTION fn_log_subscription_status_change();