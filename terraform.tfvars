
workload_name        = "APM_with_Alerts"
entity_name          = "Foodme-testing"

entity_tags = [
  {
    key   = "purpose"
    value = "user-purpose"
  },
  {
    key   = "database"
    value = "csv"
  },
  {
    key   = "browser"
    value = "true"
  }
]

alert_conditions = [
  {
    name                          = "Transactions number"
    description                   = "see the transaction number"
    runbook_url                   = "https://www.example.com"
    nrql_query                    = "FROM Transaction SELECT count(*) WHERE appName = 'Foodme-testing'"
    critical_operator            = "below"
    critical_threshold           = 100
    critical_threshold_duration  = 18000
    critical_threshold_occurrences = "ALL"
    warning_operator             = "below"
    warning_threshold            = 300
    warning_threshold_duration   = 18000
    warning_threshold_occurrences = "ALL"
  },
  {
    name                          = "Maximum Duration"
    description                   = "See the maximum duration of tranaction"
    runbook_url                   = "https://www.example.com"
    nrql_query                    = "FROM Transaction SELECT max(duration) WHERE appName = 'Foodme-testing'"
    critical_operator            = "above"
    critical_threshold           = 0.500
    critical_threshold_duration  = 120
    critical_threshold_occurrences = "ALL"
    warning_operator             = "above"
    warning_threshold            = 0.400
    warning_threshold_duration   = 180
    warning_threshold_occurrences = "ALL"
  }
]
