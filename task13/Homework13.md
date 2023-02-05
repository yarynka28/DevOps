# Homework

## [Task](https://docs.google.com/document/d/11-mHm1BWdKFaEm9HdaeALvvulKDESyGm/edit)
##### Task 1
1. Create VM
2. Configure VM
3. Add your SSH public key
4. Test SSH connection from local machine
5. Clone Kubespray release  repository
```
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
git checkout release-2.20
```
6. Copy and edit inventory file
```
cp -rfp inventory/sample inventory/mycluster
nano inventory/mycluster/inventory.ini

[all]
node1 ansible_host=34.155.230.175

[kube_control_plane]
node1

[etcd]
node1

[kube_node]
node1

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr
```
6. Turn on MetalLB
```
nano inventory\mycluster\group_vars\k8s_cluster\addons.yml
…
metallb_enabled: true
metallb_speaker_enabled: true
metallb_avoid_buggy_ips: true
metallb_ip_range:
  - "10.200.0.2/32"
# 10.200.0.2 VM private IP address 
…
nano inventory\mycluster\group_vars\k8s_cluster\k8s-cluster.yml
…
kube_proxy_strict_arp: true
…
```
7. Run execute container
```
docker run --rm -it -v /mnt/path/to/kubespray/Kubernetes2:/mnt \
  -v /home/user/path/to/ssh/keys/.ssh:/pem \
  quay.io/kubespray/kubespray:v2.20.0 bash
```
8. Go to kubespray folder and start ansible-playbook
```
cd /mnt/kubespray
ansible-playbook -i inventory/mycluster/inventory.ini --private-key /pem/id_rsa -e ansible_user=remote_user -b  cluster.yml
```
9. After successful installation connect to VM and copy kubectl configuration file.
```
ssh -i /pem/id_rsa remote_user@YOUR_VM_IP
mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chmod 777 ~/.kube/config
kubectl get nodes
```
As result, you will see installed node

##### Task 2
1. Install Ingress-controller 
```
kubectl apply -f nginx-ctl.yaml
kubectl apple -f path_provisioner.yml
kubectl get pods -n ingress-nginx -w
kubectl get svc –all-namespaces
```

##### Task 3
1. Prepare domain name (free resource https://dynv6.com/ )
2. Configure cert-manager (https://cert-manager.io/) with Letsencrypt.

##### Task 4
1. Prepare Nginx deployment:
    - Deployment
    - Service
    - Ingress (which will be connected to ClusterIssuer and use the letsencrypt certificate)



