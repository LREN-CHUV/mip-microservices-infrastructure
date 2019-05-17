[![Join the chat at https://gitter.im/HBPMedical](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/HBPMedical) [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/LREN-CHUV/mip-microservices-infrastructure/blob/master/LICENSE.md) [![Twitter](https://img.shields.io/twitter/follow/HBPmedical%20platform.svg?style=social)](https://twitter.com/intent/follow?screen_name=HBPmedical) [![StackShare](https://img.shields.io/badge/tech-stack-0690fa.svg?style=flat)](https://stackshare.io/ludovicc/medical-informatic-platform-of-the-human-brain-project) [![CircleCI](https://circleci.com/gh/LREN-CHUV/mip-microservices-infrastructure/tree/master.svg?style=svg)](https://circleci.com/gh/LREN-CHUV/mip-microservices-infrastructure/tree/master)

# Microservice infrastructure

__Current version: [![2.8.5](https://img.shields.io/badge/download-2.8.5-blue.svg)](https://github.com/HBPMedical/mip-microservices-infrastructure/archive/2.8.5.zip)__

This project contains the generic version of Ansible roles and playbooks to install, upgrade, and manage the [HBP Medical Informatics Platform](https://www.humanbrainproject.eu/en/medicine/).

The platform runs over a [Mesos](http://mesos.apache.org/) cluster and most services are managed by [Marathon](https://mesosphere.github.io/marathon/).

mip-microservices-infrastructure attempts to follow the Mantl.io project from Cisco (https://github.com/CiscoCloud/microservices-infrastructure) but with the following restrictions:

* The deployment targets are Ubuntu 16.04, CentOS 7.2+ and Redhat 7.2+
* No support for any cloud is provided, we deploy on bare-metal and pre-configured virtual machines
* We have selected only the features of Mantl that we need.

# Demos

Demonstrations are available for the various building blocks managed by this infrastructure project. The demos require a Linux machine with at least 8Gb ram, Virtualbox and Vagrant to work.

## Algorithm Factory

* [Algorithm Factory + Web Analytics](demo/algorithm-factory/algorithm-factory/web-and-algorithms/README.md)
* [Woken](demo/algorithm-factory/woken/README.md)

An other option is to use docker-compose and the [Web Analytics demo](https://github.com/HBPMedical/web-analytics-demo) project where you can test the MIP software on a Linux machine.

## Data factory

* [Airflow](demo/data-factory/airflow/README.md)

## Frontend only

* [Web portal](demo/frontend/portal/README.md)

## Developer tools

* [QA tools](demo/dev-services/qatools/README.md)

# Setup of MIP Local

**MIP Local** is a version of MIP designed to work independently from the Federation at a hospital. **MIP Local** is used to demonstrate the MIP platform and generate interest from hospitals to join the Federation. It can also be used for special research purposes, for example to work using identifying patient information.

Details about the installation of **MIP Local** can be found in the [installation documentation](https://github.com/HBPMedical/mip-microservices-infrastructure/blob/master/docs/installation/mip-local.md)

# Documentation

More documentation (configuration, installation, troubleshooting) can be found in the
[full documentation](https://github.com/HBPMedical/mip-microservices-infrastructure/blob/master/docs/)

# Development

Contributors to the platform are invited to join the following tools for collaboration:

[![Slack](https://img.shields.io/badge/slack-infrastructure%20channel-e01563.svg)](https://hbpsp8.slack.com/archives/infrastructure)  [![Trello](https://img.shields.io/badge/trello-infrastructure-blue.svg)](https://trello.com/b/h66fm9Ad/dev-research-infrastructure) [![Stories in Ready](https://badge.waffle.io/LREN-CHUV/mip-microservices-infrastructure.png?label=ready&title=stories%20ready)](https://waffle.io/LREN-CHUV/mip-microservices-infrastructure) [![Stories in In Progress](https://badge.waffle.io/LREN-CHUV/mip-microservices-infrastructure.png?label=in+progress&title=stories%20in%20progress)](https://waffle.io/LREN-CHUV/mip-microservices-infrastructure)

# License

Copyright © 2016-2019 LREN CHUV

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Acknowledgements

This work has been funded by the European Union Seventh Framework Program (FP7/2007­2013) under grant agreement no. 604102 (HBP)

This work is part of SP8 of the Human Brain Project (SGA1).
