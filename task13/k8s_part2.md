
```bash
ssh -i k8s yaryna_28@35.240.114.30
``` 

![image](https://user-images.githubusercontent.com/104198926/217777263-c7024464-281c-4b32-b0e7-4146e7d33f0f.png)

```bash
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
git checkout release-2.20
```
![image](https://user-images.githubusercontent.com/104198926/217777531-99b8a5e0-51b4-43d5-9102-364ba6189534.png)

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
![image](https://user-images.githubusercontent.com/104198926/217778404-e33ffddc-0459-4e8e-a0ba-4ca748d208b1.png)



![image](https://user-images.githubusercontent.com/104198926/217781432-5e7943fb-3998-46f9-99d5-81bbeb0a3df9.png)
