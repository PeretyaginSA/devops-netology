# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

## Задача 1
+ Опишите своими словами основные преимущества применения на практике IaaC паттернов.
+ Какой из принципов IaaC является основополагающим?

***Ответ:***
+ CI/CD - непрерывная интеграция и непрерывная доставка - разработчику нужно только написать код, а остальные процессы по тестированию, сборке и доставке проходят автоматически
+ Идемпотентность



## Задача 2

+ Чем Ansible выгодно отличается от других систем управление конфигурациями?
+ Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

***Ответ:***

+ Главное его отличие Ansible от других систем в том, что он использует существующую инфраструктуру SSH, в то время как другие (chef, puppet, и пр.) требуют установки специального PKI-окружения
+ Pull т.к. хосты могут быть оффлайн и к ним не прилетит конфиг

## Задача 3

Установить на личный компьютер:

+ VirtualBox
+ Vagrant
+ Ansible


Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.


***Ответ:***

+ VirtualBox
```bash
ubuntu@ubuntu-virtual-machine:~$ vbox-img --version
6.1.34_Ubuntur150636
```

+ Vagrant
```bash
ubuntu@ubuntu-virtual-machine:~$ vagrant -v
Vagrant 2.2.19
```
+ Ansible
```bash
ubuntu@ubuntu-virtual-machine:~$ ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/ubuntu/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.4 (main, Jun 29 2022, 12:14:53) [GCC 11.2.0]
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

+ Создать виртуальную машину.
+ Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды


`docker ps`


***Ответ:***

```bash
ubuntu@ubuntu-virtual-machine:~$ sudo vagrant provision
==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
ok: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=['git', 'curl'])

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
ok: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

```bash
ubuntu@ubuntu-virtual-machine:~$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

