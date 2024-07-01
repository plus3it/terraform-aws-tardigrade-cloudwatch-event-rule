## terraform-aws-tardigrade-cloudwatch-events

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### [2.1.0](https://github.com/plus3it/terraform-aws-tardigrade-cloudwatch-events/releases/tag/2.0.0)

**Released**: 2024.07.03

**Summary**:

*   add `sqs_target` attr
*   add `event_bus_name` attr to top level object for setting events outside default bus
*   fixed feature support for `dead_letter_config` and `event_bus_name` being available in module

### [2.0.0](https://github.com/plus3it/terraform-aws-tardigrade-cloudwatch-events/releases/tag/2.0.0)

**Released**: 2024.07.01

**Summary**:

*   Tweaked optionality to match terraform registry
*   revised variable to `event_target` to create singular object

### [1.0.0](https://github.com/plus3it/terraform-aws-tardigrade-cloudwatch-events/releases/tag/1.0.0)

**Released**: 

**Summary**:

*   Initial release of capability
