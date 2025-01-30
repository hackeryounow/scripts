# Set up the Kubernetes repository
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-aarch64/
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# Installing containerd and related package
wget https://github.com/containerd/nerdctl/releases/download/v1.7.6/nerdctl-full-1.7.6-linux-arm64.tar.gz


tar -zxvf nerdctl-full-1.7.6-linux-arm64.tar.gz -C /usr/local/
systemctl enable containerd
systemctl start containerd
ln -s  /usr/local/bin/runc /usr/local/sbin/runc
mkdir -p /opt/cni/
ln -s  /usr/local/libexec/cni/ /opt/cni/bin
rm -rf nerdctl-full-1.7.6-linux-arm64.tar.gz

# Installing kubernetes
yum install kubelet-1.27.0-0 kubeadm-1.27.0-0 kubectl-1.27.0-0 -y
systemctl enable kubelet.service
kubeadm init --kubernetes-version v1.27.16  --service-cidr=10.96.0.0/12 --pod-network-cidr=10.244.0.0/16 --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Apply CNI, e.g. Flannel
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Untaint the master node (Only for single mode)
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# Configure a default storage class
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
