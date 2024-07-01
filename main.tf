resource "aws_cloudwatch_event_rule" "this" {

  name           = var.event_rule.name
  description    = var.event_rule.description
  event_pattern  = var.event_rule.event_pattern
  event_bus_name = var.event_rule.event_bus_name
}

resource "aws_cloudwatch_event_target" "this" {

  for_each = { for target in var.event_rule.event_targets : target.name => target }

  arn            = each.value.arn
  rule           = aws_cloudwatch_event_rule.this.id
  target_id      = each.value.target_id
  role_arn       = each.value.role_arn
  event_bus_name = each.value.event_bus_name

  dynamic "dead_letter_config" {
    for_each = each.value.dead_letter_config != null ? [each.value.dead_letter_config] : []
    content {
      arn = dead_letter_config.value.arn
    }
  }

  dynamic "input_transformer" {
    for_each = each.value.input_transformer != null ? [each.value.input_transformer] : []
    content {
      input_paths    = input_transformer.value.input_paths
      input_template = input_transformer.value.input_template
    }
  }

  dynamic "sqs_target" {
    for_each = each.value.sqs_target != null ? [each.value.sqs_target] : []
    content {
      message_group_id = sqs_target.value.message_group_id
    }
  }
}
