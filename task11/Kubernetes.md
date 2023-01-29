# Kubernetes

### Execution:
1. Prepare 2 VMs (kubemaster and kubenode) with the same parametrs (4 CPU, 8 GB RAM, Ubuntu)
![image](https://user-images.githubusercontent.com/104198926/215354154-0bd4b7f6-eee6-4a16-bebd-a603d1670e15.png)
2. Connect via SSH to VMs
![image](https://user-images.githubusercontent.com/104198926/215354334-dfa89385-715a-4dc9-9d62-854288b171a7.png)
3.Run commands in two VMs (kubemaster and kubenode)
```
sudo apt update
sudo apt upgrade -y
```
> __Note!__ \
***apt-get update*** downloads the package lists from the repositories and "updates" them to get
information on the newest versions of packages and their dependencies. \
***apt-get upgrade***  will fetch new versions of packages existing on the machine if APT knows
about these new versions by way of apt-get update.

Edit the hosts file with the command: `sudo nano /etc/hosts`
![image](https://user-images.githubusercontent.com/104198926/215354654-52e82ec0-c2a3-4360-858d-5add9bdd3040.png)
Install the first dependencies with: `sudo apt install curl apt-transport-https -y` \
![image](https://user-images.githubusercontent.com/104198926/215354799-ca300630-5299-417c-9f81-484777cdf005.png)
Next, add the necessary GPG key with the command: \
`curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -`
![image](https://user-images.githubusercontent.com/104198926/215354955-983d473d-3e9b-4488-8b1e-a1729194400a.png)
Add the Kubernetes repository with: \
`echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list`
![image](https://user-images.githubusercontent.com/104198926/215354993-3a3eb3a1-70fb-42e0-af06-dd4afdc2247d.png)
Update apt: `sudo apt update` \
Install the required software with the command: `sudo apt -y install vim git curl wget kubelet kubeadm kubectl` \
![image](https://user-images.githubusercontent.com/104198926/215355035-9ca1bce8-e77e-4d7c-a796-2450c4f8e812.png)
Place kubelet, kubeadm, and kubectl on hold with: `sudo apt-mark hold kubelet kubeadm kubectl` \
![image](https://user-images.githubusercontent.com/104198926/215355056-6d002b0e-2366-4e33-a328-f7a8888825c2.png)
Start and enable the kubelet service with: `sudo systemctl enable --now kubelet` \
Next, we need to disable swap on both kubemaster. Open the fstab file for editing with:
`sudo nano /etc/fstab`.Save and close the file. \
![image](https://user-images.githubusercontent.com/104198926/215355152-e4303b6b-2360-450b-9ba7-8a39f47e7392.png) \
You can either reboot to disable swap or simply issue the following
command to finish up the job: `sudo swapoff -a` \
Enable Kernel Modules and Change Settings in sysctl:
```
sudo modprobe overlay
sudo modprobe br_netfilter
```
![image](https://user-images.githubusercontent.com/104198926/215355196-9d213c1a-b8d1-4856-9fa9-9afd7a62302f.png)
Change the sysctl settings by opening the necessary file with the command: `sudo nano /etc/sysctl.d/kubernetes.conf`
Look for the following lines and make sure they are set as you see below:
```
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
```
![image](https://user-images.githubusercontent.com/104198926/215355225-04ae9fc1-689c-41da-ba26-12765e3229a6.png)
Save and close the file. Reload sysctl with: `sudo sysctl --system`
### Install containerd
Install the necessary dependencies with:
`sudo apt install curl gnupg2 software-properties-common apt-transport-https ca-certificates -y`
![image](https://user-images.githubusercontent.com/104198926/215355268-ab5f24e7-0f07-449e-9e5e-e350f3a6944d.png)
Add the GPG key with: `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`
![image](https://user-images.githubusercontent.com/104198926/215355353-e06c9e20-7fa9-42fb-9764-6cc77b3a4713.png)
Add the required repository with: \
`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"` \
Install containerd with the commands:
```
sudo apt update
sudo apt install containerd.io -y
```
![image](https://user-images.githubusercontent.com/104198926/215355382-f8703d7f-9de6-4196-bd74-ebe90dc7eb35.png)
Change to the root user with: `sudo su` \
Create a new directory for containerd with: `mkdir -p /etc/containerd` \
Generate the configuration file with: `containerd config default>/etc/containerd/config.toml` \
Exit from the root user with:`exit` \
Restart containerd with the command:`sudo systemctl restart containerd` \
Enable containerd to run at startup with: `sudo systemctl enable containerd`
### Initialize the Master Node
Pull down the necessary container images with: `sudo kubeadm config images pull`
![image](https://user-images.githubusercontent.com/104198926/215355506-a7b18e5d-e653-426c-8add-fd23bedd5455.png)
### Command only for kubemaster :
Now, using the kubemaster IP address initialize the master node with: `sudo kubeadm init --pod-network-cidr=192.168.0.0/16`
Finally, you need to create a new directory to house a configuration file and give it the proper permissions which is done with the following commands:
```
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
![image](https://user-images.githubusercontent.com/104198926/215355533-91614cd4-255e-43e0-99ec-32fcf380a983.png) \
List Kubernetes Nodes: `kubectl get nodes`
### Command only for kubenode :
Connect kubenode to kubemaster: `sudo su` 
```
kubeadm join 10.132.0.2:6443 --token jiiqhi.o8czo1hsqk1howsr --discovery-token-ca-cert-hash \
sha256:c85d0a7d80714d266524d3947d177ce5d3cc941e8f13b0a46f4efff51769e73
```
![image](https://user-images.githubusercontent.com/104198926/215356068-34a93cd9-93c5-4264-aff4-9f89843dcb65.png)
### Comeback to kubemaster :
Install network: 
```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/custom-resources.yaml -O
kubectl create -f custom-resources.yaml
```
![image](https://user-images.githubusercontent.com/104198926/215356308-b822bfdd-3bd5-4681-8900-8167fd4e0ba8.png) \
Wait when all pods will be ready: `kubectl get pods --all-namespaces -w`
![image](https://user-images.githubusercontent.com/104198926/215356377-a25404d9-9796-4b2b-9f4d-1529c5bf8675.png)
### Result:
`kubectl get nodes -o wide`
![image](https://user-images.githubusercontent.com/104198926/215356509-6a2fe7e6-cfe0-4b73-9bb0-aa90cc78e6fa.png)
 Change the label of kubernode: `kubectl label --overwrite nodes kubernode kubernetes.io/role=worker`
![image](https://user-images.githubusercontent.com/104198926/215356513-2a1afed9-1c98-432f-bf42-22e9a8a1ecc1.png)



