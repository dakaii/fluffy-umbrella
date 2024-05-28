env "test" {
  // Declare where the schema definition resides.
  // Also supported: ["file://multi.hcl", "file://schema.hcl"].
  src = "file://schema.sql"

  // Define the URL of the database which is managed
  // in this environment.
  url = "postgres://fluffy:pass@localhost:5430/fluffy_test?search_path=public&sslmode=disable"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  dev = "docker://postgres/15/dev?search_path=public"
}

env "dev" {
  src = "file://schema.sql"
  url = "postgres://fluffy:pass@localhost:5431/fluffy_development?search_path=public&sslmode=disable"
  dev = "docker://postgres/15/dev?search_path=public"
}