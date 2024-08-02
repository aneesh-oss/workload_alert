variable "new_relic_account_id" {
  description = "The account ID for New Relic"
  type        = number
}
variable "new_relic_api_key" {
  description = "The API key for New Relic"
  type        = string
}
variable "new_relic_region" {
  description = "Region"
  type = string
}

variable "workload_name" {
  description = "The name of the New Relic workload"
  type        = string
}

variable "entity_name" {
  description = "The name of the New Relic entity"
  type        = string
}

variable "entity_tags" {
  description = "List of tags to associate with the entity"
  type = list(object({
    key    = string
    value  = string
  }))
}

variable "alert_conditions" {
  description = "List of alert conditions to create"
  type = list(object({
    name                          = string
    description                   = string
    runbook_url                   = string
    nrql_query                    = string
    critical_operator            = string
    critical_threshold           = number
    critical_threshold_duration  = number
    critical_threshold_occurrences = string
    warning_operator             = string
    warning_threshold            = number
    warning_threshold_duration   = number
    warning_threshold_occurrences = string
  }))
}
