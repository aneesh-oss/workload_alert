provider "newrelic" {
  account_id = var.new_relic_account_id
  api_key = var.new_relic_api_key
  region  = var.new_relic_region
}

data "newrelic_entity" "APM_name" {
  name   = var.entity_name
  type   = "APPLICATION"
  domain = "APM"
}

resource "newrelic_entity_tags" "APM_tags" {
  count = length(var.entity_tags)
  guid  = data.newrelic_entity.APM_name.guid

  tag {
    key    = var.entity_tags[count.index].key
    values = [var.entity_tags[count.index].value]
  }
}

resource "newrelic_workload" "APM_workload" {
  name       = var.workload_name
  account_id = var.new_relic_account_id

  entity_guids = [data.newrelic_entity.APM_name.guid]

  entity_search_query {
    query = "tags.environment = 'testing' AND tags.language='nodejs'"
  }

  scope_account_ids = [var.new_relic_account_id]
}

resource "newrelic_alert_policy" "APM_alert_policy" {
  name        = "APM Alert Policy"
  incident_preference = "PER_POLICY"
}

resource "newrelic_nrql_alert_condition" "APM_alert_condition" {
  count                  = length(var.alert_conditions)
  account_id             = var.new_relic_account_id
  policy_id              = newrelic_alert_policy.APM_alert_policy.id
  type                   = "static"
  name                   = var.alert_conditions[count.index].name
  description            = var.alert_conditions[count.index].description
  runbook_url            = var.alert_conditions[count.index].runbook_url
  enabled                = true
  violation_time_limit_seconds = 3600

  nrql {
    query = var.alert_conditions[count.index].nrql_query
  }

  critical {
    operator              = var.alert_conditions[count.index].critical_operator
    threshold             = var.alert_conditions[count.index].critical_threshold
    threshold_duration    = var.alert_conditions[count.index].critical_threshold_duration
    threshold_occurrences = var.alert_conditions[count.index].critical_threshold_occurrences
  }

  warning {
    operator              = var.alert_conditions[count.index].warning_operator
    threshold             = var.alert_conditions[count.index].warning_threshold
    threshold_duration    = var.alert_conditions[count.index].warning_threshold_duration
    threshold_occurrences = var.alert_conditions[count.index].warning_threshold_occurrences
  }
}
