variable "event_rule" {
  description = "Object of input configs for the CloudWatch Event Rule"
  type = object({
    name                = string
    description         = optional(string)
    event_pattern       = optional(string)
    event_bus_name      = optional(string, "default")
    schedule_expression = optional(string)
    state               = optional(string)

    event_targets = optional(list(object({
      name = string
      arn  = string

      event_bus_name = optional(string, "default")
      role_arn       = optional(string)
      target_id      = optional(string)

      dead_letter_config = optional(object({
        arn = string
      }))

      input_transformer = optional(object({
        input_paths    = optional(map(string))
        input_template = string
      }))

      sqs_target = optional(object({
        message_group_id = string
      }))

      retry_policy = optional(object({
        maximum_event_age_in_seconds = optional(string)
        maximum_retry_attempts       = optional(string)
      }))

    })), [])
  })
  validation {
    condition     = var.event_rule.schedule_expression == null || var.event_rule.event_bus_name == "default"
    error_message = "Scheduled expressions cannot be used on custom event buses"
  }
}
