#  Helm
To install Helm you should run this command: `sudo snap install helm --classic`

### Task1:
1. I run the helm chart: `helm install nginx-helm nginx/`
![image](https://user-images.githubusercontent.com/104198926/218409401-3609e60b-5c85-41b5-9ccb-695462102e45.png)
2. Get the list of of releases: `helm ls`
![image](https://user-images.githubusercontent.com/104198926/218409591-fc8f8010-1afc-43b3-8a97-85d7b107e2df.png)
3. Get the list of all created resources: `kubectl get all` \
![image](https://user-images.githubusercontent.com/104198926/218409731-72ed8d37-6e41-4b14-8ece-fffcd2f4f508.png)
4. Change some parameters: `helm upgrade --install --atomic nginx-helm nginx/ --set replicaCount=4`
![image](https://user-images.githubusercontent.com/104198926/218409867-777cf7ea-67cf-45b4-b522-01480ae0f15d.png)
5. Get the list of all created resources:`kubectl get all` \
![image](https://user-images.githubusercontent.com/104198926/218409955-2e085020-c66a-4329-984e-8076fd84b18e.png)
### Result:
https://yhorodetska.dynv6.net/nginx-helm
![image](https://user-images.githubusercontent.com/104198926/218410285-6dccef40-5afd-4534-9338-fb488b8c6dc1.png)

### Task2:
1. I run the helm chart: `helm install pacman pacman/`
![image](https://user-images.githubusercontent.com/104198926/218417055-96f3e5a0-7283-420b-8bbe-76e5ca8ea2af.png)
2. Get the list of of releases: `helm ls`
![image](https://user-images.githubusercontent.com/104198926/218417595-54aee50a-918d-44e1-b791-bf28b52dd5d2.png)
3. Get the list of all created resources: `kubectl get all` \
![image](https://user-images.githubusercontent.com/104198926/218417776-961465ed-be19-4794-b74e-579f03574be9.png)
