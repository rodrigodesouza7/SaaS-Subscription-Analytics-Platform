CREATE INDEX idx_subscriptions_status
ON subscriptions(status);

EXPLAIN ANALYZE
SELECT *
FROM subscriptions
WHERE status = 'active';

SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'subscriptions';