# Jenkins

### Execution:
- I installed Jenkins on my PC and run it in CommandLine![image](https://user-images.githubusercontent.com/104198926/213939490-1310470b-5c61-4363-b9c1-0004427a043e.png)
- I added useful plugins, such as workflow-multibranch, telegram-notifications, github and etc to Jenkins.
- I created a repository [BaseCamp_jenkins](https://github.com/yarynka28/BaseCamp_jenkins) with Jenkinsfile for DEV and MASTER branches
- In Jenkinsfile I created stages: 'Build', 'Test' and 'Notification', also stage, which will reproduce only on MASTER branch
- I created multi-branch job *BaseCamp_jenkins* and connect it to my git repository
![image](https://user-images.githubusercontent.com/104198926/213940569-2e0cea7c-98ca-42b3-9495-d10124081cba.png)
- I created TelegramBot and chat to get notifications, and add TOKEN_ID and CHAT_ID to credentials
![image](https://user-images.githubusercontent.com/104198926/213941684-88e248d7-649b-44ea-b5a3-f36b3dd6c403.png)
![image](https://user-images.githubusercontent.com/104198926/213940050-8853ab98-2b3c-4339-843f-adc1d0f122e7.png)

### Results:
We can see that pipeline run successfully.
![image](https://user-images.githubusercontent.com/104198926/213941783-2ec01022-a855-4eb7-93ef-9937f5bb8e58.png)
And let's look at each branch separately in BlueOcean:
- DEV
![image](https://user-images.githubusercontent.com/104198926/213941763-8aebf1e0-0009-4dea-957f-91f5c091dfb2.png)
- MASTER
![image](https://user-images.githubusercontent.com/104198926/213941737-f18dc7d1-01fd-45d6-8ce7-2304d7361849.png)
- Notification from DEV:

![image](https://user-images.githubusercontent.com/104198926/213941574-fee87c36-c575-405c-b1fe-23fa346911bb.png)
- Notification from MASTER:

![image](https://user-images.githubusercontent.com/104198926/213941834-a1940a34-c0ea-49b5-8ead-718c20533cc3.png)


### Useful links:
- [Using Jenkinsfile](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/)
- [How To Install Jenkins On Windows 10](https://www.youtube.com/watch?v=1_Zs0gQq1Yc&t=22s)
- [TelegramBot installation](https://github.com/jenkinsci/telegram-notifications-plugin#readme)
- [Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
