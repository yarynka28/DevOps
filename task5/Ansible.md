# Introduction to Ansible

### Execution:
- I created 3 EC2 instances in AWS and as a controller I used Windows 10 machine with WSL
![image](https://user-images.githubusercontent.com/104198926/209806378-a76f7c82-f720-4c4d-804f-903fd44a09bb.png)
- I created [inventory file](ansible/hosts) with four groups
- I created [role](ansible/roles/create_empty_file/tasks/main.yml) for creating an empty file /etc/iaac with rigths 0500
- I created [role](ansible/roles/fetch_linux_distro_name_version/tasks/main.yml) for fetching a linux distro name/version
- I created [ansible.cfg](ansible/ansible.cfg) file
- I created [playbook](ansible/playbook.yml)

To run a playbook I used command:
```
ansible-playbook playbook.yml
```
![image](https://user-images.githubusercontent.com/104198926/209807879-d0fb86a3-83e4-4e83-9869-0ffb2b757941.png)

To see hierarchy I used command:
```
tree ansible
```
![image](https://user-images.githubusercontent.com/104198926/209808668-752741a6-1513-4d23-b446-bb072fe3edaa.png)

> __Note!__
> If you run playbook from wsl and get the same warning, you should export ANSIBLE_CONFIG variable.For example:
> ```
> export ANSIBLE_CONFIG=./ansible.cfg
> ```
> ![image](https://user-images.githubusercontent.com/104198926/209809420-7e56e8a2-3b59-475c-956c-a7db38e40748.png)

> 

