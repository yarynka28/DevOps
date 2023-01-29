# Jenkins

### Execution:
- I installed Jenkins on my PC and run it in CommandLine![image](https://user-images.githubusercontent.com/104198926/213939490-1310470b-5c61-4363-b9c1-0004427a043e.png)
- I added useful plugins, such as workflow-multibranch, telegram-notifications, github and etc to Jenkins.
- I created a repository [BaseCamp-jenkins](https://github.com/yarynka28/BaseCamp-jenkins) with Jenkinsfile for DEV and MASTER branches
- In Jenkinsfile I created stages:'List of files and directories', 'Build', 'Test' and stage, which will reproduce only on MASTER branch. And  post action, which running on condition "always"
- I created multi-branch job *BaseCamp-jenkins* and connect it to my git repository
![image](https://user-images.githubusercontent.com/104198926/215341206-07c48bd4-afb9-4737-8e37-43700f299e51.png)
- I created TelegramBot and chat to get notifications, and add TOKEN_ID and CHAT_ID to credentials
![image](https://user-images.githubusercontent.com/104198926/215341308-c83cc271-d05a-4d4b-8101-b0b558e1ee67.png)
![image](https://user-images.githubusercontent.com/104198926/215341252-445a7f0f-3c54-46c5-83da-4740051d0b5a.png)


### Results:
**We can see that pipeline run successfully.**
![image](https://user-images.githubusercontent.com/104198926/215342087-08b57878-f336-486c-96ba-cacfae239caa.png)
**And let's look at each branch separately in BlueOcean:**
- DEV
![image](https://user-images.githubusercontent.com/104198926/215342128-3ac72713-0b0f-4f2b-a481-734c2be4c574.png)
- MASTER
![image](https://user-images.githubusercontent.com/104198926/215342150-5279b130-0b9a-48c1-9eff-187c5957a16b.png)
***Notification from DEV:*** \
![image](https://user-images.githubusercontent.com/104198926/215342165-674d2fef-53fa-4f8c-97ff-e411f73dbef4.png) \
***Notification from MASTER:*** \
![image](https://user-images.githubusercontent.com/104198926/215342180-27c62b3b-59f1-423c-bdc2-a260d5fb5898.png) \
**We can see the progress of each stage with the Pipeline Stage View plugin:**
- DEV \
![image](https://user-images.githubusercontent.com/104198926/215343385-f9ba3781-cc0b-406b-93d2-09fcca960c11.png)
- MASTER \
![image](https://user-images.githubusercontent.com/104198926/215343405-11427056-46b1-47a5-af0d-f47a2b4d1781.png)

### Useful links:
- [Using Jenkinsfile](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/)
- [How To Install Jenkins On Windows 10](https://www.youtube.com/watch?v=1_Zs0gQq1Yc&t=22s)
- [TelegramBot installation](https://github.com/jenkinsci/telegram-notifications-plugin#readme)
- [Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
