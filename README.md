# terraform-aws-tardigrade-cloudwatch-events
Module to manage cloudwatch events and targets


<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_event_rule"></a> [event\_rule](#input\_event\_rule) | Object of input configs for the CloudWatch Event Rule | <pre>object({<br/>    name                = string<br/>    description         = optional(string)<br/>    event_pattern       = optional(string)<br/>    event_bus_name      = optional(string, "default")<br/>    schedule_expression = optional(string)<br/>    state               = optional(string)<br/><br/>    event_targets = optional(list(object({<br/>      name = string<br/>      arn  = string<br/><br/>      event_bus_name = optional(string, "default")<br/>      role_arn       = optional(string)<br/>      target_id      = optional(string)<br/><br/>      dead_letter_config = optional(object({<br/>        arn = string<br/>      }))<br/><br/>      input_transformer = optional(object({<br/>        input_paths    = optional(map(string))<br/>        input_template = string<br/>      }))<br/><br/>      sqs_target = optional(object({<br/>        message_group_id = string<br/>      }))<br/><br/>      retry_policy = optional(object({<br/>        maximum_event_age_in_seconds = optional(string)<br/>        maximum_retry_attempts       = optional(string)<br/>      }))<br/><br/>    })), [])<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.

<!-- END TFDOCS -->
