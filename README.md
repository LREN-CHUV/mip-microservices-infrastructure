[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/LREN-CHUV/mip-microservices-infrastructure/blob/master/LICENSE.md) [![Twitter](https://img.shields.io/twitter/follow/HBPmedical%20platform.svg?style=social)](https://twitter.com/intent/follow?screen_name=HBPmedical) [![StackShare](https://img.shields.io/badge/tech-stack-0690fa.svg?style=flat)](https://stackshare.io/ludovicc/medical-informatic-platform-of-the-human-brain-project) [![CircleCI](https://circleci.com/gh/LREN-CHUV/mip-microservices-infrastructure/tree/master.svg?style=svg)](https://circleci.com/gh/LREN-CHUV/mip-microservices-infrastructure/tree/master) [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html)

# Microservice infrastructure

This project contains the generic version of the scripts used to deploy the Medical Informatics Platform.

The platform runs over a [Mesos](http://mesos.apache.org/) cluster and most services are managed by [Marathon](https://mesosphere.github.io/marathon/).

mip-microservices-infrastructure attempts to follow the Mantl.io project from Cisco (https://github.com/CiscoCloud/microservices-infrastructure) but with the following restrictions:

* The deployment target is Ubuntu 16.04 instead of CentOS
* No support for any cloud is provided, we deploy on bare-metal and pre-configured virtual machines
* Security, monitoring are advanced features that we may add one day, but what we aim to to is being able to switch over to Mantl once it is sufficiently stable.

Disclaimer: use this project only in a well protected development environment.

# Demos

Demonstrations are available for the various building blocks managed by this infrastructure project.

## Algorithm factory

* [Woken](demo/algorithm-factory/woken/README.md)

## Data factory

* [Airflow](demo/data-factory/airflow/README.md)

## Frontend

* [Web portal](demo/frontend/portal/README.md)

## Developer tools

* [QA tools](demo/dev-services/qatools/README.md)

# Development

[![Slack](https://img.shields.io/badge/slack-infrastructure%20channel-e01563.svg)](https://hbpsp8.slack.com/archives/infrastructure)  [![Trello](https://img.shields.io/badge/trello-infrastructure-blue.svg)](https://trello.com/b/h66fm9Ad/dev-research-infrastructure) [![Stories in Ready](https://badge.waffle.io/LREN-CHUV/mip-microservices-infrastructure.png?label=ready&title=stories%20ready)](https://waffle.io/LREN-CHUV/mip-microservices-infrastructure) [![Stories in In Progress](https://badge.waffle.io/LREN-CHUV/mip-microservices-infrastructure.png?label=in+progress&title=stories%20in%20progress)](https://waffle.io/LREN-CHUV/mip-microservices-infrastructure)

# License

Copyright © 2016 LREN CHUV

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
