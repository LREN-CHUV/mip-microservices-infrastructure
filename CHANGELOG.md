
# Changelog for the generic MIP platform

## 2.5.0 - 2017-11-08 - Glasgow release

Release highlights:

* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Modular deployment of MIP building blocks customised for hospitals (aka 'MIP Local')

Deploys:

* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) [Microservices infrastructure 1.5](https://github.com/HBPMedical/mip-microservices-infrastructure)
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Web Analytics 2.0
  * [Portal Backend 2.3.13](https://github.com/HBPMedical/portal-backend)
  * [Portal Frontend 2.3.2](https://github.com/HBPMedical/portal-frontend)
  * Portal database
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Algorithm Factory 2.0
  * [Woken 2.0.3](https://github.com/HBPMedical/woken)
  * Woken cross-validation
  * Woken database
  * Chronos 2.5
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Algorithm Library 1.0
  * [Histograms 0.3.1](https://hub.docker.com/r/hbpmip/python-histograms/)
  * [Statistics Summary](https://hub.docker.com/r/hbpmip/r-summary-stats/)
  * [Linear Regression 0.0.2](https://hub.docker.com/r/hbpmip/python-linear-regression/) (reimplementation in Python)
  * [Anova 0.3.1](https://hub.docker.com/r/hbpmip/python-anova/)
  * [KNN 0.2.1](https://hub.docker.com/r/hbpmip/java-rapidminer-knn/)
  * [Naive Bayes 0.2.0](https://hub.docker.com/r/hbpmip/java-rapidminer-naivebayes/)
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Data Factory 1.0
  * Airflow 1.8.2
  * [Airflow Imaging plugins 2.4.1](https://github.com/HBPMedical/airflow-imaging-plugins)
  * [Airflow DAGs for Data Factory 0.9.5](https://github.com/HBPMedical/data-factory-airflow-dags)
  * Matlab 2016b
  * SPM 12
  * [MRI preprocessing pipeline 1.3.0](https://github.com/HBPMedical/mri-preprocessing-pipeline)
  * [MRI Hierarchizer 1.3.4](https://github.com/HBPMedical/hierarchizer)
  * [Data Tracking 1.7.1](https://github.com/HBPMedical/data-tracking)
  * [Data Catalog database 1.6.0](https://github.com/HBPMedical/data-catalog-setup)
  * [I2B2 Import 1.6.3](https://github.com/HBPMedical/i2b2-import)
  * [EHR data to I2B2 0.2.0](https://github.com/HBPMedical/ehr-to-i2b2)
* Hospital Database 1.0
  * [![EPFL](https://img.shields.io/badge/EPFL-DIAS-6A5ACD.svg)](http://dias.epfl.ch/) PostgresRAW, PostgresRAW-ui
  * [![AUEB](https://img.shields.io/badge/aueb-wim-9D5459.svg)](http://www.aueb.gr/index_en.php) MIPMap

Changes:

[![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html)

  * Demo of Algorithm Factory + Web Analytics using Vagrant
  * Integration tests for the installation of the whole platform
  * Configuration scripts to guide the initial configuration of the platform
  * Simplified configuration organised around building blocks
  * Improve audit: use etckeeper to keep track of installations on a machine
  * Data Factory improvements: use I2B2 'capture' and I2B2 'CDE' databases to capture and normalise respectively data from the hospitals and store it into an I2B2-compatible format.
  * Automated installation of pre-processed data extracted from research datasets

## 2.0.0 - 2017-03-31 - SGA1 M12

Release highlights:

* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) First release of Data Factory for the automated processing of hospital and research data. The Data Factory includes a worflow engine and several pre-defined pipelines highly adaptable to the type of MRI scans and EHR data encountered in hospitals, memory clinics and also in research repositories.

Deploys:

* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) [Microservices infrastructure 1.5](https://github.com/HBPMedical/mip-microservices-infrastructure)
  * Mesos
  * Marathon
  * Zookeeper
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Web Analytics 2.0
  * Portal Backend
  * Portal Frontend
  * Portal database
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Algorithm Factory 2.0
  * [Woken 2.0.0](https://github.com/HBPMedical/woken)
  * [Woken database 1.0.0](https://github.com/HBPMedical/woken-db-setup)
  * Chronos
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Algorithm Library 1.0
  * Histograms
  * Statistics Summary
  * Linear Regression
  * Anova
  * KNN
  * Naive Bayes
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Data Factory 1.0
  * Airflow 1.7.1
  * [Airflow Imaging plugins 2.2.4](https://github.com/HBPMedical/airflow-imaging-plugins)
  * [Airflow DAGs for Data Factory 0.8.15](https://github.com/HBPMedical/data-factory-airflow-dags)
  * Matlab 2016b
  * SPM 12
  * [MRI preprocessing pipeline 1.2.6](https://github.com/HBPMedical/mri-preprocessing-pipeline)
  * [MRI Hierarchizer 1.2.0](https://github.com/HBPMedical/hierarchizer)
  * [Data Tracking 1.5.4](https://github.com/HBPMedical/data-tracking)
  * [Data Catalog database 1.4.5](https://github.com/HBPMedical/data-catalog-setup)
  * [I2B2 Import 1.5.4](https://github.com/HBPMedical/i2b2-import)
* Hospital Database 1.0
  * [![EPFL](https://img.shields.io/badge/EPFL-DIAS-6A5ACD.svg)](http://dias.epfl.ch/) PostgresRAW
  * [![EPFL](https://img.shields.io/badge/EPFL-DIAS-6A5ACD.svg)](http://dias.epfl.ch/) PostgresRAW-ui
  * [![AUEB](https://img.shields.io/badge/aueb-wim-9D5459.svg)](http://www.aueb.gr/index_en.php) MIPMap

Manual installations:

* [![AUEB](https://img.shields.io/badge/aueb-wim-9D5459.svg)](http://www.aueb.gr/index_en.php) WebMIPMap
* [![UOA](https://img.shields.io/badge/UOA-madgik-BDCFD6.svg)](http://www.madgik.di.uoa.gr/) Exareme

Changes:

[![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html)

* Demo of Algorithm Factory (Woken + Chronos + databases) using Vagrant
* Demo of PostgresRAW and its UI using Vagrant
* Deploy several databases onto the same Postgres server to save memory.
* Add new building block 'Data Factory'
* Track provenance information in Data Factory
* Renamed organisation on Github, from HBPSP8Repo to HBPMedical

## 1.5.0 - 2016-10-07 - SGA1 M06 - Florence release

Deploys:

* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Microservices infrastructure 1.5
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Portal backend 1.0, Portal Frontend 1.0
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Woken 1.0

Manual installations:

* [![EPFL](https://img.shields.io/badge/EPFL-DIAS-6A5ACD.svg)](http://dias.epfl.ch/) PostgresRAW, PostgresRAW-ui
* [![AUEB](https://img.shields.io/badge/aueb-wim-9D5459.svg)](http://www.aueb.gr/index_en.php) MIPMap, WebMIPMap
* [![UOA](https://img.shields.io/badge/UOA-madgik-BDCFD6.svg)](http://www.madgik.di.uoa.gr/) Exareme

Changes:

[![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html)

* Automate deployment of development tools (Gitlab, Sonarcube, Jenkins)
* Deploy a private Docker Registry
* Upgrade Mesos, Marathon, Docker to keep up with new functionalities
* Rename Workflow to Woken
* Setup etckeeper to keep track of configuration changes on all systems
* Work started on CBrain integration
* Full automated installation of Woken, Chronos, Web portal backend and frontend, all databases
* Apply database migrations from Docker to setup and upgrade all databases
* Setup Marathon health checks on all services

## 1.0.0 - 2016-03-22 - End of RUP

Deploys:

* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Microservices infrastructure 1.0
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Portal Backend 0.1
* [![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) Workflow (Woken) 0.1

Manual installations:

* [![EPFL](https://img.shields.io/badge/EPFL-DIAS-6A5ACD.svg)](http://dias.epfl.ch/) RAW
* [![AUEB](https://img.shields.io/badge/aueb-wim-9D5459.svg)](http://www.aueb.gr/index_en.php) MIPMap
* [![UOA](https://img.shields.io/badge/UOA-madgik-BDCFD6.svg)](http://www.madgik.di.uoa.gr/) Exareme

Changes:

[![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html)

* Install Workflow app (Woken), Frontend and Portal Backend
* Install Nginx, Letsencrypt, Failtoban
* Deployment inside Vagrant
* Deployment over a cluster of machines

## 0.1 - 2015-12-19

* Install Mesos, Marathon, Zookeeper, Docker

## 0.0.0 - 2015-09-03

* Start of this project aiming for an automated installation of a microservice platform and its services.
