# =============================================================
# main.tf
# Provisionamento local do ambiente SaaS Analytics
# =============================================================

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# -------------------------------------------------------------
# NETWORK
# -------------------------------------------------------------
resource "docker_network" "saas_network" {
  name = "saas_network"
}

# -------------------------------------------------------------
# VOLUMES
# -------------------------------------------------------------
resource "docker_volume" "postgres_data" {
  name = "terraform_postgres_data"
}

resource "docker_volume" "mongodb_data" {
  name = "terraform_mongodb_data"
}

# -------------------------------------------------------------
# POSTGRESQL
# -------------------------------------------------------------
resource "docker_container" "postgres" {
  name  = "tf_saas_postgres"
  image = "postgres:16"

  env = [
    "POSTGRES_DB=saas_analytics",
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres",
  ]

  ports {
    internal = 5432
    external = 5434
  }

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = docker_network.saas_network.name
  }
}

# -------------------------------------------------------------
# MONGODB
# -------------------------------------------------------------
resource "docker_container" "mongodb" {
  name  = "tf_saas_mongodb"
  image = "mongo:7"

  env = [
    "MONGO_INITDB_ROOT_USERNAME=mongo",
    "MONGO_INITDB_ROOT_PASSWORD=mongo",
  ]

  ports {
    internal = 27017
    external = 27018
  }

  volumes {
    volume_name    = docker_volume.mongodb_data.name
    container_path = "/data/db"
  }

  networks_advanced {
    name = docker_network.saas_network.name
  }
}

# -------------------------------------------------------------
# KAFKA + ZOOKEEPER
# -------------------------------------------------------------
resource "docker_container" "zookeeper" {
  name  = "tf_saas_zookeeper"
  image = "confluentinc/cp-zookeeper:7.6.0"

  env = [
    "ZOOKEEPER_CLIENT_PORT=2181",
    "ZOOKEEPER_TICK_TIME=2000",
  ]

  ports {
    internal = 2181
    external = 2182
  }

  networks_advanced {
    name = docker_network.saas_network.name
  }
}

resource "docker_container" "kafka" {
  name  = "tf_saas_kafka"
  image = "confluentinc/cp-kafka:7.6.0"

  env = [
    "KAFKA_BROKER_ID=1",
    "KAFKA_ZOOKEEPER_CONNECT=tf_saas_zookeeper:2181",
    "KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9093",
    "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1",
  ]

  ports {
    internal = 9092
    external = 9093
  }

  networks_advanced {
    name = docker_network.saas_network.name
  }
}