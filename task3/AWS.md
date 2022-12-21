# Introduction to AWS

##### Public IP of Moodle - *http://54.172.93.19*
![image](https://user-images.githubusercontent.com/104198926/208926731-6e18c56d-0426-4696-bf8b-7f5c83cfd859.png)
##### Data for test login:
```
Login name: user
Password: user_21.12_U
```
##### Useful site about Moodle installation:
https://docs.moodle.org/401/en/Step-by-step_Installation_Guide_for_Ubuntu

##### Commands used for installation:
```bash
sudo apt-get -y update
sudo apt -y install apache2
sudo apt -y install mysql-client mysql-server
sudo apt -y install php
sudo apt -y install libapache2-mod-php
sudo apt -y install graphviz aspell ghostscript php-pspell php-curl php-gd php-intl php-mysql php-xml php-xmlrpc php-ldap php-zip php-soap php-mbstring git
sudo service apache2 restart
cd /opt
sudo git clone git://git.moodle.org/moodle.git
sleep 1m
cd moodle
sudo git branch --track MOODLE_401_STABLE origin/MOODLE_401_STABLE
sudo git checkout MOODLE_401_STABLE
sudo cp -R /opt/moodle /var/www/html/
sudo mkdir /var/moodledata
sudo chown -R www-data /var/moodledata
sudo chmod -R 777 /var/moodledata
sudo chmod -R 0755 /var/www/html/moodle
sudo mysql -u root -proot
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
create user 'moodledude'@'localhost' IDENTIFIED BY 'passwordformoodledude';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON moodle.* TO 'moodledude'@'localhost';
quit;
sudo chmod 777 /etc/php/8.1/apache2/php.ini
sudo sed -i.bak 's/;max_input_vars = 1000/max_input_vars = 5000/g' /etc/php/8.1/apache2/php.ini
sudo sed -i.bak 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/moodle/g' /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart
sudo chmod -R 777 /var/www/html/moodle
```
