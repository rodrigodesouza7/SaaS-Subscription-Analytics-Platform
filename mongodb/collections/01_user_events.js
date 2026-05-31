use("saas_analytics");

db.user_events.insertMany([
  {
    customer_id: 1,
    event_type: "login",
    event_date: new Date(),
  },
  {
    customer_id: 2,
    event_type: "feature_usage",
    event_date: new Date(),
  },
  {
    customer_id: 3,
    event_type: "subscription_upgrade",
    event_date: new Date(),
  },
  {
    customer_id: 1,
    event_type: "dashboard_access",
    event_date: new Date(),
  },
]);
