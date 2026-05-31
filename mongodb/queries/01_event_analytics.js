use("saas_analytics");

db.user_events.find().pretty();

db.user_events.aggregate([
  {
    $group: {
      _id: "$event_type",
      total: { $sum: 1 },
    },
  },
]);
