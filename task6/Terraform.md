# Introduction to Terraform
To run my code you need to have [git](https://git-scm.com/downloads) and [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed on your PC.If you don't know how to install it, please follow these links:
- If your operating system *Windows*, follow next links:
  - [terraform installation](https://www.youtube.com/watch?v=Cn6xYf0QJME)
  - [git](https://www.youtube.com/watch?v=4xqVv2lTo40)
- If your operating system *Linux*, follow next links:
  - [terraform installation](https://www.youtube.com/watch?v=lSeKvTJN2ac)
  - [git](https://www.youtube.com/watch?v=PLQQ3tJwBJg)

#### How to run the code:
1. Run command `git clone https://github.com/yarynka28/DevOps/tree/main/task6` in your Command Line to clone my repository.
2. Open terminal and text editor.You can use [Visual Studio Code](https://code.visualstudio.com/download).In this program you can edit the code and it also has a built-in terminal, that is, everything can be done in one window.
3. Change directory in terminal to project directory
4. Change credentials to yours in [providers.tf](providers.tf) file.
5. Generate your SSH-key and put in [id_rsa.pub](id_rsa.pub). You can do this with command `ssh-keygen`.
6. Run `wsl.exe` on Windows, if you don`t have WSL, follow this link [WSL installation](https://learn.microsoft.com/ru-ru/windows/wsl/install).
7. Run `terraform init` to initialize providers.
8. Run `terraform apply`  to apply your code and create instances.
9. In terminal you will see IP adresses of instances, open them in your browser.
10. See My result, you should have the same
11. To detele instances, you should run `terraform destroy`
12. If you have some problems with this instruction, please follow Useful links, there you can find answers to some of your questions

## Useful links:
- [How to install Visual Studio Code on Windows 10/11](https://www.youtube.com/watch?v=JPZsB_6yHVo)
- [How to install terraform extension on Visual Studio Code](https://www.youtube.com/watch?v=PfI0fDr5yDc)
- [How to Install Windows Subsystem for Linux (WSL) in Windows 10](https://www.youtube.com/watch?v=GvHc8KvoVIA)
- [Generate ssh key for Windows](https://www.youtube.com/watch?v=oAbYL3bktMA)
- [How to Create AWS Access Key ID and Secret Access Key](https://www.youtube.com/watch?v=4u2HQCSuQpo&t=165s)
- [How to get Azure API credentials](https://www.youtube.com/watch?v=WygwzN9FfMQ)

## My result
##### Output in terminal:
![image](https://user-images.githubusercontent.com/104198926/210243645-3d19e2c7-1a8a-4e4e-87c3-9c2540d64c97.png)

##### Public IP of AWS instance - *http://54.165.37.138*
![image](https://user-images.githubusercontent.com/104198926/210243690-130db5c0-9f06-4017-b9f9-636f2235ee9e.png)

##### Public IP of Azure instance - *http://23.97.231.150*
![image](https://user-images.githubusercontent.com/104198926/210243728-a94d8635-4eee-44b3-8ef8-0c4fbcb86242.png)

##### Output in terminal after destroying:
![image](https://user-images.githubusercontent.com/104198926/210838515-3b821ebf-bfba-4820-86e9-2881408be930.png)

