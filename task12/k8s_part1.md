#  K8S_part1

### Execution:
***1. Get information about worker node and save it in file:*** \
`kubectl describe nodes kubernode > worker_description.txt` \
[To see worker_description.txt file, click here](worker_description.txt)
![image](https://user-images.githubusercontent.com/104198926/217012103-6f8884dd-2748-490c-ae10-8512ab9bf389.png)

***2. Create a new namespace:*** \
`kubectl create ns k8s` \
![image](https://user-images.githubusercontent.com/104198926/217012355-d47922d2-67f0-4cd9-b2ac-9bb6bdc615c0.png)

***3. Prepare [deployment.yaml](deployment.yaml) file which will create a Deployment with 3 pods of Nginx and service for access to these pods via ClusterIP and NodePort:*** \
Run deployment.yaml file : `kubectl apply -f ./deployment.yaml -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217026235-bfd07753-4e93-45ef-816a-909a033f0206.png) \
Get a list of deployments: `kubectl get deployment -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217026433-b424ec50-37e4-4a24-af34-6672b22a971c.png) \

> __Note!__ \
`-n` flag used to display resources in a specific namespace

Get a list of pods: `kubectl get pods -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217026623-941ad6a6-e87e-4716-b39d-6d62b47fbc10.png) \
 Get a list of services: `kubectl get services -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217026911-795c3fb1-00c1-47bd-88fd-97297251e186.png) \
Get a description of the deployment: `kubectl describe deploy nginx-deployment -n k8s` 
![image](https://user-images.githubusercontent.com/104198926/217027295-5ec168cf-18cc-4a6c-b300-c6e1b65b57af.png) \
Get a description of the service:
```
kubectl describe service nodeport -n k8s
kubectl describe service clusterip -n k8s
```
![image](https://user-images.githubusercontent.com/104198926/217027688-85953cc6-62a4-4cf4-89eb-215c33214ce1.png) \
 Get a list of replicaset: `kubectl get replicaset -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217027941-2de7edbd-c266-4ace-8676-a0a1569b56fc.png) \
 Get a log of the pod: `kubectl logs nginx-deployment-6b7f675859-8wq97 -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217030256-acd1fe12-f8a9-4c9e-b5c6-6e80437e4e6e.png) \
 Get a log of the pod: `kubectl logs nginx-deployment-6b7f675859-dpjp7 -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217030334-423df752-02da-49a0-9ae7-a4c6a2562546.png) \
 Get a log of the pod: `kubectl logs nginx-deployment-6b7f675859-jmg54 -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217030412-842bb826-0430-4e57-8fcb-a3e109b061ad.png) \

***4. Prepare two job yaml files:*** \
Run [job-internal-port.yaml](job-internal-port.yaml) file: `kubectl apply -f ./job-internal-port.yaml -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217032981-89ee184b-ec0c-411f-907d-530f80a9e240.png) \
Get a log of the job: `kubectl logs job.batch/job-internal-port -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217033483-56af4922-937e-4566-a904-fe0b0e70584b.png) \
Run [job-external-port.yaml](job-external-port.yaml) file: `kubectl apply -f ./job-external-port.yaml -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217033865-003c4bf7-9722-4fc9-ba68-e1d0e73e943a.png) \
Get a log of the job: `kubectl logs job.batch/job-external-port -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217075341-c057a0e8-cb9a-42f1-8ab1-a883820124eb.png) \
Get a list of jobs: `kubectl get job -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217075489-4a77f419-bb17-44fd-981e-f35b4aa5bf2d.png) \
 Get a description of the job: `kubectl describe job job-internal-port -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217075768-75025a56-b363-4471-9eb9-3632e0a192e6.png) \
 Get a description of the job: `kubectl describe job job-external-port -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217075904-973e5ebc-4926-449d-8ff0-243dd6a8c95a.png) \

***5. Prepare Cronjob.yaml file which will test the connection to Nginx service every 3 minutes.*** \
Run [Cronjob.yaml](Cronjob.yaml) file: `kubectl apply -f ./Cronjob.yaml -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217031461-0d0686e5-bff9-45ae-8bc2-de1730412a0d.png) \
 Get a list of cronjob: `kubectl get CronJob -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217031648-d442bb4f-7835-4934-a40d-c1349c084724.png) \
 Get a list of job created by cronjob: `kubectl get job -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217077202-8474b693-ac96-48e9-9f68-af109be14f06.png) \
 Get a log of job created by cronjob: `kubectl logs job/cronjob-27928581 -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217077572-1bc36b3a-6e2b-4a82-9298-1660b2e039fb.png) \
Get a description of the cronjob: `kubectl describe cronjob cronjob -n k8s` \
![image](https://user-images.githubusercontent.com/104198926/217077798-5dec0dae-b1c6-459a-ad51-de7f5dcaafab.png)



