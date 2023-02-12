#  K8S_part2

### Task1:
1. I create and configurate VM instance in GCP:
![image](https://user-images.githubusercontent.com/104198926/218323271-0e4f83be-92a1-4cff-9568-b4726820de09.png)
2. I generate and add my public SSH key to VM:
![image](https://user-images.githubusercontent.com/104198926/218323375-dc022f2a-ab54-4624-a01b-9709bc512b5d.png)
3. I test SSH connection from local machine:
```
ssh -i k8s yaryna_28@35.240.114.30
``` 
![image](https://user-images.githubusercontent.com/104198926/217777263-c7024464-281c-4b32-b0e7-4146e7d33f0f.png) \
4. I clone Kubespray release repository:
```bash
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
git checkout release-2.20
```
![image](https://user-images.githubusercontent.com/104198926/218283108-06ed9f87-5dad-4071-b78e-cdea18760219.png) \
![image](https://user-images.githubusercontent.com/104198926/218283116-87e6d2ed-3d8b-4043-88de-932a0b96a5a5.png) \
5. I copy and edit inventory file:
```
cp -rfp inventory/sample inventory/mycluster
nano inventory/mycluster/inventory.ini
```
```ini
[all]
node1 ansible_host=35.240.114.30

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
![image](https://user-images.githubusercontent.com/104198926/217778404-e33ffddc-0459-4e8e-a0ba-4ca748d208b1.png) \
6. I turn on MetalLB
```
nano inventory\mycluster\group_vars\k8s_cluster\addons.yml
```
![image](https://user-images.githubusercontent.com/104198926/217781432-5e7943fb-3998-46f9-99d5-81bbeb0a3df9.png)
```
nano inventory\mycluster\group_vars\k8s_cluster\k8s-cluster.yml
```
`kube_proxy_strict_arp: true` \
7. I run execute container:
```
docker run --rm -it -v /mnt/c/Users/Asus/Desktop/DevOps/k8s/kubespray:/mnt/kubespray -v /home/Asus/.ssh/keys/:/pem quay.io/kubespray/kubespray:v2.20.0 bash
```
8. I go to kubespray folder and start ansible-playbook
```
cd /mnt/kubespray
ansible-playbook -i inventory/mycluster/inventory.ini --private-key /pem/k8s -e ansible_user=yaryna_28 -b  cluster.yml
```
![image](https://user-images.githubusercontent.com/104198926/218315680-d9c499f7-ef68-4a37-a71d-8f7e885376f7.png)
![image](https://user-images.githubusercontent.com/104198926/218315741-772d898f-395c-4c15-83e2-ba967f62f55b.png) \
9. After successful installation I connect to my VM:
`ssh -i /pem/k8s yaryna_28@34.79.182.243`
![image](https://user-images.githubusercontent.com/104198926/218315761-4c9169d8-ce46-40d4-ab2c-bf5090a3f0a6.png) \
10. I copy kubectl configuration file:
```
mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chmod 777 ~/.kube/config
kubectl get nodes
kubectl get ns
```
![image](https://user-images.githubusercontent.com/104198926/218315784-8aae649d-ff61-49aa-a793-9a42bd3ecc04.png)

### Task2:
1. I install Ingress-controller
```
kubectl apply -f nginx-ctl.yaml
```
![image](https://user-images.githubusercontent.com/104198926/218315903-d91a1ef4-1e44-40c1-a544-5fbea6cbe2e5.png)
```
kubectl apply -f path_provisioner.yaml
```
![image](https://user-images.githubusercontent.com/104198926/218315888-d39296d9-441f-45f2-b17d-e4592332ef2a.png)
```
kubectl get pods -n ingress-nginx -w
```
![image](https://user-images.githubusercontent.com/104198926/218315939-5fdc112b-9e8f-4b10-b4a2-baf05055217e.png)
```
kubectl get svc --all-namespaces
```
![image](https://user-images.githubusercontent.com/104198926/218315965-46627e89-6766-41ab-a242-1705c213c079.png)

### Task3:
1. I prepare domain name using [free resource](https://dynv6.com/) \
![image](https://user-images.githubusercontent.com/104198926/218315981-91497794-6816-4948-a09b-2b8c3d302b1a.png)
2. I install cert-manager:
`kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml`
![image](https://user-images.githubusercontent.com/104198926/218316012-63f9ab24-e2db-404f-a8e0-e6849467700c.png)
 
 ### Task4:
 1. I run deployment.yaml file:
 ```
 kubectl apply -f deployment.yaml
 ```
 List of pods:
 ```
 kubectl get pods
 ```
 ![image](https://user-images.githubusercontent.com/104198926/218316067-34ad2c10-e399-4cef-9748-540ca3970481.png)
2. I run ingress.yaml file:
```
kubectl apply -f ingress.yaml
```
 List of ingress:
 ```
 kubectl get ingress
 ```
 ![image](https://user-images.githubusercontent.com/104198926/218324516-f3dedab9-e935-4502-adc3-35899450d06d.png)
 3.I run letsencrypt-staging:
 ```
 kubectl apply -f staging-issuer.yaml
 ```
 4.I run letsencrypt-prod:
 ```
 kubectl apply -f production-issuer.yaml
 ```
 






