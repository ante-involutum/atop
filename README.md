# Atop

Automated Testing Open Platform

![Atop overview](./img/overview.png)

## Goals

- Test engineers can use any language, any framework to carry out automated testing activities
- Resolve high availability issues in testing activities
- Committed to improving test efficiency

## How it works

Relying on the native capabilities of Kubernetes, atop provides the management capability of Test Pod, runs the test code in the container, and uses [Fliebeat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-overview.html) real-time collection of test results from filestream or http and centralized analysis and processing

## Why Atop?

It is very difficult to write highly available and distributed test code, Atop will provide this capability natively; Atop will build a test environment, execute tests, collect test data, send alarms and other activities in a modular form to automate and independently run, as far as possible It can improve the efficiency of testing activities; third-party testing applications or frameworks only need to do a certain degree of transformation to access Atop, and testing activities are easier to access to the cloud platform.

![aomaker overview](./img/aomaker.png)

## Feature

- Interface automation testing
- Interface performance test

## Quickstarts

See [Start](https://github.com/no8ge/cli/blob/main/README.md) guid

### Contact Us

| Platform  | Link        |
|:----------|:------------|
| 📧 Mail | lunz1207@gmail.com

## Repositories

| Repo | Description |
|:-----|:------------|
| [Atop](https://github.com/no8ge/atop) | The main repository that you are currently in
| [CLI](https://github.com/no8ge/cli) | The Dapr CLI allows you to setup Atop on your local dev machine or on a Kubernetes cluster
| [Files](https://github.com/no8ge/files) | file handling
| [Analysis](https://github.com/no8ge/analysis) | data analysis
| [Tink](https://github.com/no8ge/tink) | Runtime control module
| [Console](https://github.com/no8ge/console) | web
| [Chartrepo](https://github.com/no8ge/chartrepo) | Helm chart repo
| [Demo](https://github.com/no8ge/demo) | Demo
