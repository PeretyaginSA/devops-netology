# Домашнее задание к занятию "5.5. Оркестрация кластером Docker контейнеров на примере Docker Swarm"

## Задача 1
Дайте письменые ответы на следующие вопросы:

+ В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?
+ Какой алгоритм выбора лидера используется в Docker Swarm кластере?
+ Что такое Overlay Network?


## Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:

`docker node ls`

***Ответ:***

```bash
[root@node01 centos]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
pydocwpq544q3ckjy16roays6 *   node01.netology.yc   Ready     Active         Leader           20.10.18
ruglmziil4zpt6th6zjxwtwki     node02.netology.yc   Ready     Active         Reachable        20.10.18
l543llcvfzsoc8bow148d3fgn     node03.netology.yc   Ready     Active         Reachable        20.10.18
u6n9axzd9vrtlh6rc4r6uu9hw     node04.netology.yc   Ready     Active                          20.10.18
m0qqj68pquxy7m0xtv6qvq0im     node05.netology.yc   Ready     Active                          20.10.18
vm1haixmrw887qm4l5n0jebar     node06.netology.yc   Ready     Active                          20.10.18
```




## Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:

`docker service ls`

***Ответ:***

```bash
[root@node01 centos]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
qzxbwh4ca1k6   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0    
cqtr51od1t0m   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
7zoe6mcivzpz   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest                         
m1dkkgb4z3mv   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest                      
n3upcv5688nn   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4           
v9wqe7bskbaf   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0   
z291rkbbgjn5   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0       
kmcsnh7tr5aq   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0  
```

## Задача 4 (*)

Выполнить на лидере Docker Swarm кластера команду (указанную ниже) и дать письменное описание её функционала, что она делает и зачем она нужна:

```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```




***Ответ:***

```bash
[root@node01 centos]# docker swarm update --autolock=true
Swarm updated.
To unlock a swarm manager after it restarts, run the `docker swarm unlock`
command and provide the following key:

    SWMKEY-1-c8mjxReoQOM7KShDDQOSUwaRnmhYX2d0PABiOs4rJ9o

Please remember to store this key in a password manager, since without it you
will not be able to restart the manager.
```

