# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Задача 1

Сценарий выполения задачи:

+ создайте свой репозиторий на https://hub.docker.com;
+ выберете любой образ, который содержит веб-сервер Nginx;
+ создайте свой fork образа;
+ реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```

Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

***Ответ:***


https://hub.docker.com/repository/docker/peretyaginsa/nginx tag = v0.0.5

Для запуска - docker run -d -p 8080:80 peretyaginsa/nginx:v0.0.5

index.html скопировал по средствам Dockerfile COPY

![image](https://user-images.githubusercontent.com/106968319/187865804-b319bb3f-42d2-438b-a9b9-1120a60311bb.png)



## Задача 2
Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

---

Сценарий:



+ Высоконагруженное монолитное java веб-приложение;
+ Nodejs веб-приложение;
+ Мобильное приложение c версиями для Android и iOS;
+ Шина данных на базе Apache Kafka;
+ Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
+ Мониторинг-стек на базе Prometheus и Grafana;
+ MongoDB, как основное хранилище данных для java-приложения;
+ Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

***Ответ:***


+ Высоконагруженное монолитное java веб-приложение;<br>
    \- *Физический сервер,  для использования всех ресурсов, и не расходуя их на гипервизор.*

+ Nodejs веб-приложение;<br>
    \- *Docker в полне подойдет он позволит быстро развернуть приложение.*

+ Мобильное приложение c версиями для Android и iOS;<br>
    \- *Docker для тестировки*

+ Шина данных на базе Apache Kafka;<br>
    \- *Docker значительно упрощает развертывание*

+ Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;<br>
    \- *Docker для создания ELK Stack*

+ Мониторинг-стек на базе Prometheus и Grafana;


+ MongoDB, как основное хранилище данных для java-приложения;


+ Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.





## Задача 3


+ Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку `/data` из текущей рабочей директории на хостовой машине в `/data` контейнера;
+ Запустите второй контейнер из образа debian в фоновом режиме, подключив папку `/data` из текущей рабочей директории на хостовой машине в `/data` контейнера;
+ Подключитесь к первому контейнеру с помощью `docker exec` и создайте текстовый файл любого содержания в `/data`;
+ Добавьте еще один файл в папку /data на хостовой машине;
+ Подключитесь во второй контейнер и отобразите листинг и содержание файлов в `/data` контейнера.


***Ответ:***

`docker run -v /data:/data -itd centos`

`docker run -v /data:/data -itd debian`

```bash
root@server1:/# docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS         PORTS     NAMES
444e4da5b4ac   debian    "bash"        8 seconds ago   Up 7 seconds             elated_nash
7ad101502520   centos    "/bin/bash"   3 minutes ago   Up 3 minutes             unruffled_hermann
```

`docker exec -it unruffled_hermann bash`

```
[root@7ad101502520 /]# touch data/for-centos
[root@7ad101502520 /]# ls data/
for-centos
```

`root@server1:/# touch data/for-host`


`docker exec -it elated_nash bash`

```
root@444e4da5b4ac:/# ls -l data/
-rw-r--r-- 1 root root 0 Sep  1 14:24 for-centos
-rw-r--r-- 1 root root 0 Sep  1 14:27 for-host
```


## Задача 4 (*)


Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.


***Ответ:***

Выполнено

https://hub.docker.com/repository/docker/peretyaginsa/ansible tag = v0.0.1


















