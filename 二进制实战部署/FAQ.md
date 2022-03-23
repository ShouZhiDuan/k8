# FAQ

## 1、`kubectl get cs`显示schduler（No Healthy）

```shell
root@node-1:~# kubectl get cs
Warning: v1 ComponentStatus is deprecated in v1.19+
NAME                 STATUS    MESSAGE             ERROR
scheduler            Healthy   ok                  
controller-manager   Healthy   ok                  
etcd-2               Healthy   {"health":"true"}   
etcd-1               Healthy   {"health":"true"}   
etcd-0               Healthy   {"health":"true"} 
```

```shell
root@node-1:/# cat /etc/systemd/system/kube-scheduler.service
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-scheduler \
  --authentication-kubeconfig=/etc/kubernetes/kube-scheduler.kubeconfig \
  --authorization-kubeconfig=/etc/kubernetes/kube-scheduler.kubeconfig \
  --kubeconfig=/etc/kubernetes/kube-scheduler.kubeconfig \
  --leader-elect=true \
  --bind-address=0.0.0.0 \
  #注释这个端口，否则kubectl get cs查看scheduler状态不对。
  #--port=0 \ 
  --v=1
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

## 2、coredns启动显示OOMKilled

### 2.1、修改coredns deployment

执行：`kubectl edit deployment coredns -n kube-system`

![image-20220323172433296](C:\Users\dev\AppData\Roaming\Typora\typora-user-images\image-20220323172433296.png)

### 2.2、修改coredns configmap

执行`kubectl edit configmap coredns -n kube-system`

![image-20220323172831122](C:\Users\dev\AppData\Roaming\Typora\typora-user-images\image-20220323172831122.png)

去掉上面中的loop一行。

## 3、反编译证书

执行`openssl x509 -text -noout -in ./kubernetes.pem`

下面可以看到证书所允许得访问IP列表

![image-20220323173153164](C:\Users\dev\AppData\Roaming\Typora\typora-user-images\image-20220323173153164.png)

## 4、nfs文件系统无法挂在的问题

[参考文档](https://blog.csdn.net/ag1942/article/details/115371793)

```shell
root@node-1:~# vi /etc/systemd/system/kube-apiserver.service
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-apiserver \
  #需要加上--feature-gates=RemoveSelfLink=false，否则nfs挂载异常
  #V1.20.2默认是这个参数
  --feature-gates=RemoveSelfLink=false \
  --advertise-address=210.37.68.73 \
  --allow-privileged=true \
  --apiserver-count=2 \
  --audit-log-maxage=30 \
  --audit-log-maxbackup=3 \
  --audit-log-maxsize=100 \
  --audit-log-path=/var/log/audit.log \
  --authorization-mode=Node,RBAC \
  --bind-address=0.0.0.0 \
  --client-ca-file=/etc/kubernetes/ssl/ca.pem \
  --enable-admission-plugins=NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \
  --etcd-cafile=/etc/kubernetes/ssl/ca.pem \
  --etcd-certfile=/etc/kubernetes/ssl/kubernetes.pem \
  --etcd-keyfile=/etc/kubernetes/ssl/kubernetes-key.pem \
  --etcd-servers=https://210.37.68.78:2379,https://210.37.68.79:2379,https://210.37.68.80:2379 \
  --event-ttl=1h \
  --kubelet-certificate-authority=/etc/kubernetes/ssl/ca.pem \
  --kubelet-client-certificate=/etc/kubernetes/ssl/kubernetes.pem \
  --kubelet-client-key=/etc/kubernetes/ssl/kubernetes-key.pem \
  --service-account-issuer=api \
  --service-account-key-file=/etc/kubernetes/ssl/service-account.pem \
  --service-account-signing-key-file=/etc/kubernetes/ssl/service-account-key.pem \
  --api-audiences=api,vault,factors \
  --service-cluster-ip-range=10.233.0.0/16 \
  --service-node-port-range=30000-32767 \
  --proxy-client-cert-file=/etc/kubernetes/ssl/proxy-client.pem \
  --proxy-client-key-file=/etc/kubernetes/ssl/proxy-client-key.pem \
  --runtime-config=api/all=true \
  --requestheader-client-ca-file=/etc/kubernetes/ssl/ca.pem \
  --requestheader-allowed-names=aggregator \
  --requestheader-extra-headers-prefix=X-Remote-Extra- \
  --requestheader-group-headers=X-Remote-Group \
  --requestheader-username-headers=X-Remote-User \
  --tls-cert-file=/etc/kubernetes/ssl/kubernetes.pem \
  --tls-private-key-file=/etc/kubernetes/ssl/kubernetes-key.pem \
  --v=1
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

























