# Introduction to Microsoft Azure

##### Public IP of VM1 - *http://4.236.155.31/*
![image](https://user-images.githubusercontent.com/104198926/206923740-892c3a21-5374-4372-803d-5a5d129a88d4.png)
##### Public IP of VM2 - *http://4.227.129.93/*
![image](https://user-images.githubusercontent.com/104198926/206923757-80875fa2-bfbf-495a-9b77-456035232897.png)
##### Public IP of Load Balancer - *http://20.157.6.23/* 
![image](https://user-images.githubusercontent.com/104198926/206923506-58f43d06-fb9e-425d-bae8-d52a9c7be432.png)
![image](https://user-images.githubusercontent.com/104198926/206923511-ae949e7f-12d8-41db-b9fa-df47274f5294.png)

##### Template for web-server installation:
```bash
#cloud-config
package_upgrade: true
packages:
  - nginx
  - nodejs
  - npm
write_files:
  - owner: www-data:www-data
  - path: /etc/nginx/sites-available/default
    content: |
      server {
        listen 80;
        location / {
          proxy_pass http://localhost:3000;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection keep-alive;
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
        }
      }
  - owner: azureuser:azureuser
  - path: /home/azureuser/myapp/index.js
    content: |
      var express = require('express')
      var app = express()
      var os = require('os');
      app.get('/', function (req, res) {
        res.send('Yaryna Horodetska host ' + os.hostname() + '!')
      })
      app.listen(3000, function () {
        console.log('Hello world app listening on port 3000!')
      })
runcmd:
  - service nginx restart
  - cd "/home/azureuser/myapp"
  - npm init
  - npm install express -y
  - nodejs index.js
```
