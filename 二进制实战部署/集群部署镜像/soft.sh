# 设定版本号
export VERSION=v1.20.2
export CONTAINERD_VERSION=1.4.3


# 下载master节点组件
wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kube-apiserver
wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kube-controller-manager
wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kube-scheduler
wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl

# 下载worker节点组件
wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kube-proxy
wget https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubelet

# 下载etcd组件
wget https://github.com/etcd-io/etcd/releases/download/v3.4.10/etcd-v3.4.10-linux-amd64.tar.gz

# 下载containerd
wget https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/cri-containerd-cni-${CONTAINERD_VERSION}-linux-amd64.tar.gz