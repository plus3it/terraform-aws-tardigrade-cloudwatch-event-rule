resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
  numeric = false
}

module "cloudwatch" {
  for_each = { for item in local.event_rules : item.name => item }
  source   = "../../"

  event_rule = each.value
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}


locals {
  event_rules = [
    {
      name                = "event1"
      description         = random_string.this.result
      schedule_expression = "rate(5 minutes)"
      event_bus_name      = "default"
      state               = "ENABLED"
      event_pattern = jsonencode({
        source      = ["aws.codecommit"],
        detail-type = ["${random_string.this.result}"],
        account     = [data.aws_caller_identity.current.account_id],
        region      = [data.aws_region.current.region],
        resources   = ["arn:${data.aws_partition.current.partition}:codecommit:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${random_string.this.result}"],
        detail = {
          destinationReference = ["${random_string.this.result}"],
          isMerged             = ["${random_string.this.result}"],
          pullRequestStatus    = ["${random_string.this.result}"],
        }
      })
      event_targets = [
        #input_transformer dynamic
        {
          name     = "target1"
          arn      = "arn:${data.aws_partition.current.partition}:codebuild:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:project/${random_string.this.result}"
          role_arn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/service-role/Amazon_EventBridge_Invoke_CodeBuild_1840626416"
          input_transformer = {
            input_paths = {
              destination-version = "$.detail.destinationReference"
            }
            input_template = "{\"destinationVersion\": <destination-version>}"
          }
        },
        #dead_letter_config dynamic
        {
          name     = "target2"
          arn      = "arn:${data.aws_partition.current.partition}:codebuild:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:project/${random_string.this.result}"
          role_arn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/service-role/Amazon_EventBridge_Invoke_CodeBuild_1840626416"
          dead_letter_config = {
            arn = "arn:${data.aws_partition.current.partition}:sqs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${random_string.this.result}"
          }
        },
        #sqs_target dynamic
        {
          name     = "target3"
          arn      = "arn:${data.aws_partition.current.partition}:codebuild:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:project/${random_string.this.result}"
          role_arn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/service-role/Amazon_EventBridge_Invoke_CodeBuild_1840626416"
          sqs_target = {
            message_group_id = "${random_string.this.result}"
          }
        }
      ]
    },
    {
      name        = "event2"
      description = random_string.this.result
      event_pattern = jsonencode({
        source      = ["aws.codecommit"],
        detail-type = ["${random_string.this.result}"],
        account     = [data.aws_caller_identity.current.account_id],
        region      = [data.aws_region.current.region],
        resources   = ["arn:${data.aws_partition.current.partition}:codecommit:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${random_string.this.result}"],
        detail = {
          destinationReference = ["${random_string.this.result}"],
          isMerged             = ["${random_string.this.result}"],
          pullRequestStatus    = ["${random_string.this.result}"],
        }
      })
      event_targets = [
        #all dynamics
        {
          name     = "target1"
          arn      = "arn:${data.aws_partition.current.partition}:codebuild:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:project/${random_string.this.result}"
          role_arn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/service-role/Amazon_EventBridge_Invoke_CodeBuild_1840626416"
          input_transformer = {
            input_paths = {
              destination-version = "$.detail.destinationReference"
            }
            input_template = "{\"destinationVersion\": <destination-version>}"
          }
          dead_letter_config = {
            arn = "arn:${data.aws_partition.current.partition}:sqs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${random_string.this.result}"
          }
          sqs_target = {
            message_group_id = "${random_string.this.result}"
          }
          retry_policy = {
            maximum_event_age_in_seconds = 60
            maximum_retry_attempts       = 10
          }
        }
      ]
    },
  ]
}
