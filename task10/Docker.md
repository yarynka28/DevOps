# Docker

### Execution:
#### Task 1:
1. I installed Docker Desktop on my PC(Windows 10 OS).You can see [video](https://www.youtube.com/watch?v=5nX8U8Fz5S0) how to do it.
2. I prepared a [Dockerfile](task1/Dockerfile) based on Nginx image
3. I added my [index.html](task1/index.html) page with my name and surname to the docker image
4. I built an image based on Dockerfile with command `docker built -t nginx:latest .`
![image](https://user-images.githubusercontent.com/104198926/214804333-cd146987-9dd5-4176-854d-12bc773f0a9b.png)
5. I ran the docker container at port 8080 with command `docker run --name task10_1 -d -p 8080:80 nginx:latest`. 
![image](https://user-images.githubusercontent.com/104198926/214804524-237ea865-12ee-49e6-8f6b-8a2edd614a1c.png)
> __Note!__ \
***`docker ps`***  is used to list the containers 
![image](https://user-images.githubusercontent.com/104198926/214807505-1bb1a59a-81d3-4910-af26-020a17c25977.png)
***`-t`*** flag means tag of your image \
***`--name`*** flag means name of your container \
***`-p`*** flag means port mapping \
***`-d`***  flag means that a Docker container runs in the background of your terminal
6. I opened [page](http://localhost:8080/) in Web Browser and saw my name and surname \
![image](https://user-images.githubusercontent.com/104198926/214803752-3806d9d3-86c5-407e-b9b8-5d9c80609162.png)

#### Task 2:
1. I prepared private and public networks
      - private `docker network create private --internal`
      ![image](https://user-images.githubusercontent.com/104198926/214808287-235cf8f2-0eaa-4617-84ba-a63bca66f1e7.png)
      - public `docker network create public` \
      ![image](https://user-images.githubusercontent.com/104198926/214808523-ae31593c-be52-44fe-9d74-9811ff90a011.png)
2. I prepared a [Dockerfile](task2/Dockerfile) based on ubuntu image with the ping command
3. I built an image based on Dockerfile with command `docker built -t ubuntu_ping.v1 .`
![image](https://user-images.githubusercontent.com/104198926/214808042-75902dfe-2c6c-48ae-896e-cc80d14dcf36.png)
4. I ran two containers: one container has access to the private and public networks and the second container
is in the private network
```
docker run --name public_container -d --network public ubuntu_ping.v1
docker network connect private public_container
docker run --name private_container -d --network private ubuntu_ping.v1
```
![image](https://user-images.githubusercontent.com/104198926/214809486-c4f9e641-97ea-419b-8c94-4498c4664d1d.png)
> __Note!__ \
If you want to see detailed information about your container, network and etc, you can use `docker inspect`,
I used it to inspect created networks
- `docker network inspect private`
![image](https://user-images.githubusercontent.com/104198926/214810794-a1499b6e-0700-46c0-ba18-8ec35770e95a.png)
- `docker network inspect public`
![image](https://user-images.githubusercontent.com/104198926/214810843-2de92bd4-c895-432a-a10b-53919daf8b9f.png)
5. I used `docker exec -it name_of_container /bin/bash` to connect to a container that is already running.
      - `docker exec -it public_container /bin/bash`
      ![image](https://user-images.githubusercontent.com/104198926/214812498-74d4dce8-84cb-4b09-b477-9741d321cd8d.png)
      - `docker exec -it private_container /bin/bash`
      ![image](https://user-images.githubusercontent.com/104198926/214812638-314c97c9-e094-4179-909e-da70522aad49.png) \
*Results:* \
We have seen that from public_container we can ping both Internet resources and private_container. After joining the private container, we saw that the public_container is being pinged, because it is in a private network, but the Internet resources are not available.
