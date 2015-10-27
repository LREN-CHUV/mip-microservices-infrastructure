
# Microservice infrastructure

This project contains the generic version of the scripts used to deploy the Medical Informatics Platform.

It attempts to follow the Mantl.io project from Cisco (https://github.com/CiscoCloud/microservices-infrastructure) but with the following restrictions:

* The deployment target is Ubuntu instead of CentOS
* No support for any cloud is provided, we deploy on bare-metal and pre-configured virtual machines
* Security, monitoring are avanced features that we may add one day, but what we aim to to is being able to switch over to Mantl once it is sufficiently stable.

Disclaimer: use this project only in a well protected development environment.
