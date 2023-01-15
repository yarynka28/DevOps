# Hardening

### Execution:
- I created EC2 instance in AWS
![image](https://user-images.githubusercontent.com/104198926/212567001-1eb65d2b-6e8d-4a29-9bfd-e882369f7803.png)
- I created [inventory file](hosts)
- I created [role](roles/install_packages/tasks/main.yml) for installing packages
- I created [role](roles/harden_passwords/tasks/main.yml) for hardening users' passwords
- I created [ansible.cfg](ansible.cfg) file
- I created [playbook](playbook.yml)

To run a playbook I used command in WSL:
```
ansible-playbook playbook.yml --private-key .ssh/task7-8.pem
```
![image](https://user-images.githubusercontent.com/104198926/212567300-eef768cf-de6b-4bf6-8f27-1ac5b26317d1.png)
To connect to the instance I used command in WSL:
```
ssh -i "task7-8.pem" ubuntu@ec2-44-201-206-143.compute-1.amazonaws.com
```
### Results:
#### Changing password for user `user12`:
- Add user \
![image](https://user-images.githubusercontent.com/104198926/212567585-c20d30ef-8321-40d5-b661-80b63d0ca1d9.png)
- The first attempt was `12345678`, second - `1234` and last - `user1234`
![image](https://user-images.githubusercontent.com/104198926/212567599-59dd9bb2-39a2-4ae3-9da0-e1549cda3769.png)
- The successful attemp was `basecamp1`
- ![image](https://user-images.githubusercontent.com/104198926/212567809-89bd5ba5-6bb4-446e-9282-6ee15d5a2f7f.png)
#### Changing password for `root`:
- The first attempt was `1234`, second - `root1234` and last - `12345678`
![image](https://user-images.githubusercontent.com/104198926/212567871-861c207a-519c-44e8-8b02-a19f6709f7b2.png)
- The successful attemp was `globalcamp` \
![image](https://user-images.githubusercontent.com/104198926/212567913-a2806a9b-c3fb-4c65-8af0-1bf8443e6592.png)
