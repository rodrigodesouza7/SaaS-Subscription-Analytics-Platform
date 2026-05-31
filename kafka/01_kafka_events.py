# =============================================================
# 01_kafka_events.py
# Producer de eventos SaaS para Kafka
# =============================================================

from kafka import KafkaProducer
import json
import random
from datetime import datetime

KAFKA_BROKER = "localhost:9092"

EVENTS = [
    "USER_SIGNED_UP",
    "SUBSCRIPTION_STARTED",
    "PLAN_UPGRADED",
    "PLAN_DOWNGRADED",
    "PAYMENT_FAILED",
    "FEATURE_USED",
    "SUBSCRIPTION_CANCELLED",
]

producer = KafkaProducer(
    bootstrap_servers=KAFKA_BROKER,
    value_serializer=lambda v: json.dumps(v).encode("utf-8"),
)

def generate_event():
    return {
        "event_type" : random.choice(EVENTS),
        "customer_id": random.randint(1, 500),
        "timestamp"  : datetime.utcnow().isoformat(),
        "plan_id"    : random.randint(1, 4),
        "amount"     : round(random.uniform(29.90, 499.90), 2),
    }

if __name__ == "__main__":
    print("Enviando 1000 eventos para o Kafka...")
    for i in range(1000):
        event = generate_event()
        producer.send("saas-events", value=event)
        if i % 100 == 0:
            print(f"Enviados: {i} eventos")

    producer.flush()
    print("Concluído — 1000 eventos enviados ao tópico saas-events")