# atop

Automated Testing Open Platform, 自动化测试开放平台

![atop overview](./img/overview.png)
![aomaker overview](./img/aomaker.png)

## 目标

- 测试工程师能使用任何语言, 任何框架，开展自动化测试活动
- 解决测试活动中的高可用问题
- 致力于测试效率提升

## 它是怎么工作的

依托 Kubernetes 的原生能力, atop 提供 Test Pod 的管理能力, 将测试代码运行在容器中，通过 [Fliebeat](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-overview.html) 从 filestream 或者 http 实时收集测试结果并集中分析处理

## 为什么选择 atop?

编写高可用、分布式的测试代码是很困难的, atop将原生提供这种能力

atop 将搭建测试环境，执行测试、收集测试数据、发送告警等活动以模块化的形式自动化独立运行，尽可能的提高测试活动的效率

第三方的测试应用或者框架只需要做一定程度的改造即可接入atop，测试活动更容易上云平台

## 功能

- 接口自动化测试
- 接口性能测试

## 快速开始

参考 [开始](https://github.com/no8ge/cli/blob/main/README.md) 指引

### 联系我们

| 平台  | 链接        |
|:----------|:------------|
| 📧 Mail | lunz1207@gmail.com

## 仓库

| 仓库 | 描述 |
|:-----|:------------|
| [Atop](https://github.com/no8ge/atop) | 主仓库
| [CLI](https://github.com/no8ge/cli) | 命令行工具
| [Files](https://github.com/no8ge/files) | 测试文件存储
| [Analysis](https://github.com/no8ge/analysis) | 测试数据处理
| [Tink](https://github.com/no8ge/tink) | runtime 控制模块
| [Console](https://github.com/no8ge/console) | 前端页面
| [Chartrepo](https://github.com/no8ge/chartrepo) | Helm chart 仓库
| [Demo](https://github.com/no8ge/demo) | Kubernetes 应用 demo
