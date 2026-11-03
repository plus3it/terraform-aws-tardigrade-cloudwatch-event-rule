# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module creates one EventBridge (CloudWatch Events) rule and a set of targets for it. The only input is the `event_rule` object: the rule settings (`name`, `event_pattern`, `schedule_expression`, `event_bus_name`, `state`) plus an `event_targets` list, and each target can set a dead letter queue, an input transformer, an SQS message group, and a retry policy. The module has no outputs, and it rejects a `schedule_expression` on any event bus other than `default`.
