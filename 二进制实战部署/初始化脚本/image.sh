#初始化所有带有work角色节点的镜像

echo "======1、拉取集群基础镜像======"
docker pull docker.io/calico/cni:v3.22.1           
docker pull docker.io/calico/node:v3.22.1 
docker pull docker.io/calico/pod2daemon-flexvol:v3.22.1
docker pull docker.io/coredns/coredns:1.6.7
docker pull docker.io/library/mysql:5.7
docker pull docker.io/library/nginx:1.19
docker pull registry.cn-hangzhou.aliyuncs.com/kubernetes-kubespray/pause:3.2
docker pull registry.cn-hangzhou.aliyuncs.com/kubernetes-kubespray/dns_k8s-dns-node-cache:1.16.0


echo "======2、推送到自己仓库======"
#1、docker.io/library/mysql:5.7
docker tag 05311a87aeb4 registry.cn-qingdao.aliyuncs.com/dszk8/mysql:5.7 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/mysql:5.7
#2、docker.io/calico/cni:v3.22.1
docker tag 2a8ef6985a3e registry.cn-qingdao.aliyuncs.com/dszk8/calico_cni:v3.22.1 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/calico_cni:v3.22.1
#3、docker.io/calico/pod2daemon-flexvol
docker tag 17300d20daf9 registry.cn-qingdao.aliyuncs.com/dszk8/calico_pod2daemon-flexvol:v3.22.1 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/calico_pod2daemon-flexvol:v3.22.1
#4、docker.io/calico/node:v3.22.1
docker tag 7a71aca7b60f registry.cn-qingdao.aliyuncs.com/dszk8/calico_node:v3.22.1 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/calico_node:v3.22.1
#5、docker.io/library/nginx:1.19
docker tag f0b8a9a54136 registry.cn-qingdao.aliyuncs.com/dszk8/nginx:1.19 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/nginx:1.19
#6、k8s.gcr.io/pause:3.2
docker tag 80d28bedfe5d registry.cn-qingdao.aliyuncs.com/dszk8/pause:3.2 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/pause:3.2
#7、docker.io/coredns/coredns:1.6.7
docker tag 67da37a9a360 registry.cn-qingdao.aliyuncs.com/dszk8/coredns:1.6.7 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/coredns:1.6.7 
#8、registry.cn-hangzhou.aliyuncs.com/kubernetes-kubespray/dns_k8s-dns-node-cache:1.16.0
docker tag 90f9d984ec9a registry.cn-qingdao.aliyuncs.com/dszk8/dns_k8s-dns-node-cache:1.16.0 && \
docker push registry.cn-qingdao.aliyuncs.com/dszk8/dns_k8s-dns-node-cache:1.16.0


echo "======3、拉取镜像tag为官方镜像======"
#1、docker.io/library/mysql:5.7
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/mysql:5.7 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/mysql:5.7 docker.io/library/mysql:5.7

#2、docker.io/calico/cni:v3.22.1
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/calico_cni:v3.22.1 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/calico_cni:v3.22.1 docker.io/calico/cni:v3.22.1

#3、docker.io/calico/pod2daemon-flexvol
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/calico_pod2daemon-flexvol:v3.22.1 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/calico_pod2daemon-flexvol:v3.22.1 docker.io/calico/pod2daemon-flexvol

#4、docker.io/calico/node:v3.22.1
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/calico_node:v3.22.1 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/calico_node:v3.22.1 docker.io/calico/node:v3.22.1

#5、docker.io/library/nginx:1.19
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/nginx:1.19 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/nginx:1.19 docker.io/library/nginx:1.19

#6、k8s.gcr.io/pause:3.2
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/pause:3.2 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/pause:3.2 k8s.gcr.io/pause:3.2

#7、docker.io/coredns/coredns:1.6.7
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/coredns:1.6.7 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/coredns:1.6.7 docker.io/coredns/coredns:1.6.7

#8、registry.cn-hangzhou.aliyuncs.com/kubernetes-kubespray/dns_k8s-dns-node-cache:1.16.0
crictl pull registry.cn-qingdao.aliyuncs.com/dszk8/dns_k8s-dns-node-cache:1.16.0 && \
ctr -n k8s.io i tag registry.cn-qingdao.aliyuncs.com/dszk8/dns_k8s-dns-node-cache:1.16.0 registry.cn-hangzhou.aliyuncs.com/kubernetes-kubespray/dns_k8s-dns-node-cache:1.16.0