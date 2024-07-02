variable "postgres_host" {
  type    = string
  default = getenv("POSTGRES_HOST")
}

variable "postgres_database" {
  type    = string
  default = getenv("POSTGRES_DB")
}

variable "postgres_user" {
  type    = string
  default = getenv("POSTGRES_USER")
}

variable "postgres_password" {
  type    = string
  default = getenv("POSTGRES_PASSWORD")
}

variable "postgres_port" {
  type    = string
  default = getenv("POSTGRES_PORT")
}
env "test" {
  // Declare where the schema definition resides.
  // Also supported: ["file://multi.hcl", "file://schema.hcl"].
  src = "file://schema.sql"

  // Define the URL of the database which is managed
  // in this environment.
  // url = "postgres://fluffy:pass@localhost:5430/fluffy_test?search_path=public&sslmode=disable"
  url = "postgres://${var.postgres_user}:${var.postgres_password}@${var.postgres_host}:${var.postgres_port}/${var.postgres_database}?search_path=public&sslmode=disable"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  // dev = "docker://postgres/15/dev?search_path=public"
  // dev = "postgres://fluffy:pass@host.docker.internal:5434/dev?sslmode=disable"
  // dev = "postgres://${var.postgres_user}:${var.postgres_password}@${var.postgres_host}:${var.postgres_port}/dev?sslmode=disable"
  dev = "sqlite://dev?mode=memory"
}

env "dev" {
  src = "file://schema.sql"
  url = "postgres://fluffy:pass@localhost:5431/fluffy_development?search_path=public&sslmode=disable"
  dev = "docker://postgres/15/dev?search_path=public"
}