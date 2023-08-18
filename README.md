# atop

Automated Testing Open Platform 自动化测试开放平台, 让自动化测试更加简单。

## 特点

- 支持任何框架
- 支持任何语言
- 高可用
- 云原生

## 功能

- 自动化测试执行
- 通知
- 监控告警
- 测试报告持久化
- 测试数据持久化

## 快速开始

### 依赖

- Kubernetes
- helm

### 安装

使用 [k3d](https://k3d.io/v5.5.2/) 创建一个集群, 如果你已经有一个多节点 Kubernets 集群可以跳过此步骤。

```shell
k3d cluster create
```

添加 atop chart 仓库并更新

```shell
helm repo add atop https://no8ge.github.io/chartrepo/
helm repo update
```

安装 apisix 网关到集群

```shell
～ helm upgrade --install apisix atop/apisix --create-namespace --namespace apisix --set gateway.http.nodePort=31690 --set dashboard.enabled=true --set ingress-controller.enabled=true --set ingress-controller.config.apisix.serviceNamespace=apisix


~ Release "apisix" does not exist. Installing it now.
NAME: apisix
LAST DEPLOYED: Fri Aug 18 09:01:06 2023
NAMESPACE: apisix
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export NODE_PORT=$(kubectl get --namespace apisix -o jsonpath="{.spec.ports[0].nodePort}" services apisix-gateway)
  export NODE_IP=$(kubectl get nodes --namespace apisix -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT
```

安装 atop 平台到集群

```shell
# host: 网关ip
# port: 网关端口
# env: stable
～ helm upgrade --install test atop/atop --version "1.0.0" --create-namespace --namespace atop --set hosts="127.0.0.1" --set env=stable --set port=31690
```

使用 [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) 查看 Pod 状态, Pod 均为 Running 状态即可

```shell
~ kubectl get pod -n apisix
NAME                                         READY   STATUS    RESTARTS       AGE
apisix-etcd-2                                1/1     Running   1 (106s ago)   2m1s
apisix-etcd-1                                1/1     Running   1 (106s ago)   2m1s
apisix-etcd-0                                1/1     Running   2 (101s ago)   2m1s
apisix-b4f57c89f-gvvm2                       1/1     Running   0              2m1s
apisix-ingress-controller-7bd688f7d4-dnlsx   1/1     Running   0              2m1s
apisix-dashboard-6648b854b7-bv6m9            1/1     Running   4 (45s ago)    2m1s

~ kubectl get pod -n atop
NAME                            READY   STATUS    RESTARTS   AGE
test-demo-558954b7bb-g2tgz      1/1     Running   0          15m
test-analysis-6cf5b49bf-q48kk   1/1     Running   0          15m
test-auth-6d6d7f989c-hcxcg      1/1     Running   0          15m
test-tink-54c4dcf544-5npvl      1/1     Running   0          15m
test-files-66478844bb-zg95m     1/1     Running   0          15m
test-minio-69d8f5d8b8-cl69r     1/1     Running   0          15m
test-elasticsearch-master-0     1/1     Running   0          15m
test-filebeat-dk2mr             1/1     Running   0          15m
```

暴露网关服务到本地

```shell
~ kubectl port-forward  svc/apisix-gateway 31690:80 -n apisix
Forwarding from 127.0.0.1:31690 -> 9080
Forwarding from [::1]:31690 -> 9080
```

### 开始一个(简要)测试

被测系统 : [Demo](https://github.com/no8ge/demo)

部署环境 : 集群内部

```shell
NAME                            READY   STATUS    RESTARTS   AGE
test-demo-558954b7bb-g2tgz      1/1     Running   0          15m
```

#### pytest

创建一个测试 Pod

```shell
# request
curl -X POST -H "Content-Type: application/json" -H "Authorization: admin" http://127.0.0.1:31690/stable/tink/v1.1/chart -d '{"type":"pytest","name":"test-1","uid":"091143e5-464e-4704-8438-04ecc98f4b1a","container":{"image": "mx2542/demo:1.0.0","command":"pytest --html=report/report.html -s -v","report": "/demo/report"}}'

# response:
{"outs":{"name":"091143e5-464e-4704-8438-04ecc98f4b1a","info":{"first_deployed":"2023-08-18T06:17:25.718271114Z","last_deployed":"2023-08-18T06:17:25.718271114Z","deleted":"","description":"Install complete","status":"deployed"},"config":{"container":{"command":"pytest --html=report/report.html -s -v","image":"mx2542/demo:1.0.0","report":"/demo/report"},"name":"test-1","type":"pytest"},"version":1,"namespace":"atop"},"errs":""}
```

查看 Pod 以及日志

```shell
~ kubectl get pod -n atop |grep 091143e5-464e-4704-8438-04ecc98f4b1a                                 
NAME                                          READY   STATUS      RESTARTS   AGE
pytest-091143e5-464e-4704-8438-04ecc98f4b1a   0/1     Completed   0          86s

# 通过 kubernetes 查看 Pod 日志
～ kubectl logs pytest-091143e5-464e-4704-8438-04ecc98f4b1a -n atop
============================= test session starts ==============================
platform linux -- Python 3.7.9, pytest-7.2.0, pluggy-1.0.0 -- /usr/local/bin/python
cachedir: .pytest_cache
metadata: {'Python': '3.7.9', 'Platform': 'Linux-6.4.8-orbstack-00059-g106c60a3471f-x86_64-with-debian-10.5', 'Packages': {'pytest': '7.2.0', 'pluggy': '1.0.0'}, 'Plugins': {'anyio': '3.6.2', 'html': '3.2.0', 'metadata': '3.0.0'}}
rootdir: /demo
plugins: anyio-3.6.2, html-3.2.0, metadata-3.0.0
collecting ... collected 3 items

tests/test_demo.py::TestDemo::test_read_root PASSED
tests/test_demo.py::TestDemo::test_read_item PASSED
tests/test_demo.py::TestDemo::test_anythings PASSED

------------- generated html file: file:///demo/report/report.html -------------
============================== 3 passed in 0.47s ===============================
2023-08-18 06:17:32.659 | INFO     | __main__:<module>:9 - ====== atop 开始处理测试报告 ======
2023-08-18 06:17:32.661 | INFO     | __main__:<module>:11 - 测试报告路径为: /demo/report
2023-08-18 06:17:32.661 | INFO     | __main__:<module>:14 - 测试报告名称为: pytest-091143e5-464e-4704-8438-04ecc98f4b1a
2023-08-18 06:17:32.661 | INFO     | __main__:<module>:62 - 开始复制测试报告到文件服务器共享存储目录:/report/pytest-091143e5-464e-4704-8438-04ecc98f4b1a/demo/report ...
2023-08-18 06:17:32.662 | INFO     | __main__:<module>:65 - 存在同名目录: /report/pytest-091143e5-464e-4704-8438-04ecc98f4b1a/demo/report
2023-08-18 06:17:32.662 | INFO     | __main__:<module>:66 - 删除同名目录: /report/pytest-091143e5-464e-4704-8438-04ecc98f4b1a/demo/report
2023-08-18 06:17:32.663 | INFO     | __main__:<module>:71 - 复制完成
2023-08-18 06:17:32.664 | INFO     | __main__:push:38 - minio客户端连接成功
2023-08-18 06:17:32.664 | INFO     | __main__:push:48 - ==开始备份测试报告至minio
2023-08-18 06:17:32.686 | INFO     | __main__:push:51 - ==测试报告已备份至minio
2023-08-18 06:17:32.686 | INFO     | __main__:<module>:79 - ======= atop 完成测试报告处理 =======
```

通过 atop 接口查看 Pod 状态

```shell
# request
curl -X GET -H "Content-Type: application/json" -H "Authorization: admin" http://127.0.0.1:31690/stable/tink/v1.1/pod -d '{"type":"pytest","name":"test-1","uid":"091143e5-464e-4704-8438-04ecc98f4b1a"}'  

# response
{"api_version":"v1","kind":"Pod","status":{"conditions":[{"last_probe_time":null,"last_transition_time":"2023-08-18T06:17:25+00:00","message":null,"reason":"PodCompleted","status":"True","type":"Initialized"},{"last_probe_time":null,"last_transition_time":"2023-08-18T06:17:33+00:00","message":null,"reason":"PodCompleted","status":"False","type":"Ready"},{"last_probe_time":null,"last_transition_time":"2023-08-18T06:17:33+00:00","message":null,"reason":"PodCompleted","status":"False","type":"ContainersReady"},{"last_probe_time":null,"last_transition_time":"2023-08-18T06:17:25+00:00","message":null,"reason":null,"status":"True","type":"PodScheduled"}],"container_statuses":[{"container_id":"containerd://0116a917fcd3687aa5f96824580976f9a53038ad6db20a0c870b5684f6ae3427","image":"docker.io/mx2542/demo:1.0.0","image_id":"docker.io/mx2542/demo@sha256:b9e758834810da6dfcdd971a35f9231b1d6dbbcee39b5c07df9653e24692e7d8","last_state":{"running":null,"terminated":null,"waiting":null},"name":"pytest","ready":false,"restart_count":0,"started":false,"state":{"running":null,"terminated":{"container_id":"containerd://0116a917fcd3687aa5f96824580976f9a53038ad6db20a0c870b5684f6ae3427","exit_code":0,"finished_at":"2023-08-18T06:17:32+00:00","message":null,"reason":"Completed","signal":null,"started_at":"2023-08-18T06:17:31+00:00"},"waiting":null}}],"ephemeral_container_statuses":null,"host_ip":"192.168.228.2","init_container_statuses":null,"message":null,"nominated_node_name":null,"phase":"Succeeded","pod_ip":"10.42.0.84","pod_i_ps":[{"ip":"10.42.0.84"}],"qos_class":"BestEffort","reason":null,"start_time":"2023-08-18T06:17:25+00:00"}}  
```

通过 atop 接口查看 Pod 日志

```shell
# todo: fix k3d 兼容性
# request
curl -X POST -H "Content-Type: application/json" -H "Authorization: admin" http://127.0.0.1:31690/stable/analysis/raw -d '{"index":"logs","key_words":{"kubernetes.labels.uid":"091143e5-464e-4704-8438-04ecc98f4b1a"},"from_":0,"size":200}'  
```

查看测试报告

```shell
# request
curl -H "Content-Type: application/json" -H "Authorization: admin" http://127.0.0.1:31690/stable/files/v1.1/report -d '{"type":"pytest","uid":"091143e5-464e-4704-8438-04ecc98f4b1a","path":"/demo/report"}'  

# response
{"url":"http://127.0.0.1:31690/stable/share/pytest-091143e5-464e-4704-8438-04ecc98f4b1a/demo/report/report.html","status":"completed"}  

# 浏览器打开 
open http://127.0.0.1:31690/stable/share/pytest-091143e5-464e-4704-8438-04ecc98f4b1a/demo/report/report.html  
```

![pytest overview](./img/pytest.png)

### 第三方框架接入

- 将测试代码构建为一个 Docker 镜像, 保证能正常运行
- 在测试代码中实现一个 metrics 接口(或者 metrics.log 文件), atop 平台会通过 filebeat 或者 prometheus 实时采集 metrics 入库

## 仓库

| 仓库 | 描述 |
|:-----|:------------|
| [Atop](https://github.com/no8ge/atop) | 主仓库
| [Analysis](https://github.com/no8ge/analysis) | 测试数据分析处理
| [CLI](https://github.com/no8ge/cli) | 命令行工具
| [Console](https://github.com/no8ge/console) | 平台前端
| [Chartrepo](https://github.com/no8ge/chartrepo) | Helm chart 仓库
| [Demo](https://github.com/no8ge/demo) | 测试用 demo
| [Files](https://github.com/no8ge/files) | 文件报告处理
| [Tink](https://github.com/no8ge/tink) | 测试执行控制模块

### 联系我们

| 平台  | 链接        |
|:----------|:------------|
| 📧 Mail | <lunz1207@gmail.com>
