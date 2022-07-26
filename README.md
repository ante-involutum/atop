<div style="text-align: center"><img src="/img/atop_logo.png" height="120px">
<h2>任何语言, 任何框架, 任何测试</h2>
</div>

Atop将自动化测试的最佳实践设计成开放、独立和模块化的方式，让你能够运行使用任意的开发语言和框架展开高可用、可移植的测试活动

![atop overview](./img/overview.png)

## 目标

- 测试工程师能使用任何语言, 任何框架，开展自动化测试活动
- 解决测试活动中的高可用, 弹性伸缩问题
- 模块化运行测试
- 构建完整的测试生态
- 致力于测试效率提升

## 它是怎么工作的

Atop 提供基于容器的测试运行环境, 依托 Kubernetes 原生的高可用、弹性伸缩能力，将测试应用以job、deployment的形式运行，通过ELK方案以及后端监听器收集测试数据并展示。

## 为什么选择 Atop?

编写高可用、分布式的测试是很困难的。Atop将原生提供这种能力

Atop 将自动化测试实践中搭建测试环境，执行测试、收集测试数据、发送告警等活动以模块化的形式自动化独立运行，尽可能的提高测试活动的效率。

第三方的测试应用（框架）只需要做一定程度的改造即可接入Atop，构建更加完善的测试生态

## 功能

* 测试文件存储、分发、版本管理
* 测试数据收集
* 测试数据展示
* 分布式运行测试

## Get Started using Dapr

See our [Getting Started](https://docs.dapr.io/getting-started/) guide over in our docs.

### 联系我们

| 平台  | 链接        |
|:----------|:------------|
| 📧 Mail | [@lunz1207](lunz1207@gmail.com)

## Repositories

| 仓库 | 描述 |
|:-----|:------------|
| [Atop](https://github.com/ante-involutum/atop) | 主仓库，主要是文档和使用说明
| [CLI](https://github.com/ante-involutum/cli) | 命令行工具, 主要用于Atop的安装、升级、卸载,也提供测试活动想过的快捷操作
| [Files](https://github.com/ante-involutum/files) | 测试文件存储、分发
| [Analysis](https://github.com/ante-involutum/analysis) | 测试数据过滤、整理、展示
| [Tink](https://github.com/ante-involutum/tink) | runtime 控制模块，包括创建、销毁等
| [Console](https://github.com/ante-involutum/console) | 前端页面.
| [Chartrepo](https://github.com/ante-involutum/chartrepo) | Helm chart 仓库
| [Demo](https://github.com/ante-involutum/demo) | Kubernetes 应用 demo，也作为被测系统
| [Jmeter](https://github.com/ante-involutum/jmeter) | Jmeter runtime
