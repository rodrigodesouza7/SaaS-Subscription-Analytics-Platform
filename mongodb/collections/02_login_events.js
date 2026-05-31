// =============================================================
// 02_login_events.js
// Geração de massa de dados — login_events
// =============================================================

use("saas_analytics");

const devices = ["desktop", "mobile", "tablet"];
const locations = ["SP", "RJ", "MG", "RS", "PR", "BA", "CE", "PE"];
const statuses = ["success", "success", "success", "failed"];

let batch = [];

for (let i = 1; i <= 50000; i++) {
  batch.push({
    customer_id: Math.ceil(Math.random() * 500),
    device: devices[Math.floor(Math.random() * devices.length)],
    location: locations[Math.floor(Math.random() * locations.length)],
    status: statuses[Math.floor(Math.random() * statuses.length)],
    timestamp: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000),
  });

  if (batch.length === 1000) {
    db.login_events.insertMany(batch);
    batch = [];
  }
}

if (batch.length > 0) {
  db.login_events.insertMany(batch);
}

print("login_events inseridos: " + db.login_events.countDocuments());

// =============================================================
// 03_audit_logs.js
// Geração de massa de dados — audit_logs
// =============================================================

const entities = ["subscription", "invoice", "payment", "support_ticket"];
const actions = [
  "created",
  "updated",
  "canceled",
  "upgraded",
  "downgraded",
  "deleted",
];

let auditBatch = [];

for (let i = 1; i <= 30000; i++) {
  auditBatch.push({
    entity: entities[Math.floor(Math.random() * entities.length)],
    entity_id: Math.ceil(Math.random() * 1000),
    action: actions[Math.floor(Math.random() * actions.length)],
    customer_id: Math.ceil(Math.random() * 500),
    timestamp: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000),
  });

  if (auditBatch.length === 1000) {
    db.audit_logs.insertMany(auditBatch);
    auditBatch = [];
  }
}

if (auditBatch.length > 0) {
  db.audit_logs.insertMany(auditBatch);
}

print("audit_logs inseridos: " + db.audit_logs.countDocuments());
