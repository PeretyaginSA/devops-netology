# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:

+ установке elasticsearch
+ первоначальном конфигурировании elastcisearch
+ запуске elasticsearch в docker


Используя докер образ elasticsearch:7 как базовый:

+ составьте Dockerfile-манифест для elasticsearch
+ соберите docker-образ и сделайте push в ваш docker.io репозиторий
+ запустите контейнер из получившегося образа и выполните запрос пути / c хост-машины

Требования к elasticsearch.yml:

+ данные path должны сохраняться в /var/lib
+ имя ноды должно быть netology_test

В ответе приведите:

+ текст Dockerfile манифеста
+ ссылку на образ в репозитории dockerhub
+ ответ elasticsearch на запрос пути / в json виде

Подсказки:

+ при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
+ при некоторых проблемах вам поможет docker директива ulimit
+ elasticsearch в логах обычно описывает проблему и пути ее решения
+ обратите внимание на настройки безопасности такие как xpack.security.enabled
+ если докер образ не запускается и падает с ошибкой 137 в этом случае может помочь настройка -e ES_HEAP_SIZE
+ при настройке path возможно потребуется настройка прав доступа на директорию


Далее мы будем работать с данным экземпляром elasticsearch.



***Ответ:***

1.
```
FROM elasticsearch:7.17.7
ADD elasticsearch.yml /usr/share/elasticsearch/config
RUN mkdir /var/lib/logs && \
    chown elasticsearch:elasticsearch /var/lib/logs && \
    mkdir /var/lib/data && \
    chown elasticsearch:elasticsearch /var/lib/data
```

2. 
`https://hub.docker.com/repository/docker/peretyaginsa/elastic`

3.
```bash
root@3941133a3792:/usr/share/elasticsearch# curl -X GET 'localhost:9200/'
```
```json
{
  "name" : "netology_test",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "gXgIlwiISf2A6qutsZJy4w",
  "version" : {
    "number" : "7.17.6",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "f65e9d338dc1d07b642e14a27f338990148ee5b6",
    "build_date" : "2022-08-23T11:08:48.893373482Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

## Задача 2
В этом задании вы научитесь:

+ создавать и удалять индексы
+ изучать состояние кластера
+ обосновывать причину деградации доступности данных

Ознакомтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик	| Количество шард |
|---|---|---|
| ind-1	| 0 |	1 |
| ind-2 |	1 |	2 |
| ind-3 |	2	| 4 |


Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард, иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.


***Ответ:***

****Список индексов и их статусов:****
```bash
root@3941133a3792:/usr/share/elasticsearch# curl -X GET 'localhost:9200/_cat/indices?'
green  open ind-1                     XYFnhRL8SaKRnRwRYlVt3g 1 0  0 0   226b   226b
yellow open ind-3                     QC2g3vcOTxqITb43W6Oqog 4 2  0 0   904b   904b
yellow open ind-2                     PXdRrpNQTLqmwW5IVFr7tQ 2 1  0 0   452b   452b

root@3941133a3792:/usr/share/elasticsearch# curl -X GET 'localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "docker-cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
root@3941133a3792:/usr/share/elasticsearch# curl -X GET 'localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "docker-cluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 62.96296296296296
}
root@3941133a3792:/usr/share/elasticsearch# curl -X GET 'localhost:9200/_cluster/health/ind-3?pretty'
{
  "cluster_name" : "docker-cluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 62.96296296296296
```

****Состояние кластера:****

```bash
root@3941133a3792:/usr/share/elasticsearch# curl -X GET 'localhost:9200/_cluster/health/?pretty=true'
{
  "cluster_name" : "docker-cluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 17,
  "active_shards" : 17,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 62.96296296296296
  ```
  
`yellow — какие-то шарды отсутствуют/инициализируются, но оставшихся кластеру достаточно, чтобы собраться в консистентное состояние`



****Удалени:****

`curl -X DELETE 'http://localhost:9200/ind-1?pretty'`<br>
`curl -X DELETE 'http://localhost:9200/ind-2?pretty'`<br>
`curl -X DELETE 'http://localhost:9200/ind-3?pretty'`<br>

```bash
root@3941133a3792:/usr/share/elasticsearch# curl -X DELETE 'http://localhost:9200/ind-1?pretty'
{
  "acknowledged" : true
}
```

## Задача 3
В данном задании вы научитесь:

+ создавать бэкапы данных
+ восстанавливать индексы из бэкапов


Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API зарегистрируйте данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

Создайте `snapshot` состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshotами`.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

Восстановите состояние кластера `elasticsearch` из `snapshot`, созданного ранее.

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:

+ возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`


***Ответ:***


1.
```bash
root@3941133a3792:/usr/share/elasticsearch# curl -XPOST localhost:9200/_snapshot/netology_backup?pretty -H 'Content-Type: application/json' -d'{"type": "fs", "settings": { "location":"/usr/share/elasticsearch/snapshots" }}'
{
  "acknowledged" : true
}
```


2.  индекс test

`curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'`
```bash
root@3941133a3792:/usr/share/elasticsearch# curl 'localhost:9200/_cat/indices?v&pretty'
health status index                     uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases          8mULwHuiQCCNXcB8fzvEAQ   1   0          3            0      2.6mb          2.6mb
green  open   test                      OaeXEbN2S7-FdRXp-C7wMA   1   0          0            0       226b           226b
green  open   .geoip_databases_restored 8aHXyYzFQ6yhkUmQC0EwYw   1   0         40            0     38.4mb         38.4mb
```




3.  Создание snapshot


`curl -X PUT localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true`

```bash
root@3941133a3792:/usr/share/elasticsearch# ls -l snapshots/
total 40
drwxrwxr-x 14 elasticsearch root  4096 Nov 21 15:29 indices
-rw-rw-r--  1 elasticsearch root 30142 Nov 21 15:29 meta-Vz-OSwSQRuK8S3EkK9yUEQ.dat
-rw-rw-r--  1 elasticsearch root  1576 Nov 21 15:29 snap-Vz-OSwSQRuK8S3EkK9yUEQ.dat
```

4. Удалите индекс test и создайте индекс test-2

```bash
root@3941133a3792:/usr/share/elasticsearch# curl -X DELETE 'http://localhost:9200/test?pretty'
{
  "acknowledged" : true
}
```


`curl -X PUT localhost:9200/test-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'`

```bash
root@3941133a3792:/usr/share/elasticsearch# curl 'localhost:9200/_cat/indices?v&pretty'
health status index                     uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2                    lgfD_uWXRBOKGcJEL0Y2qw   1   0          0            0       226b           226b
green  open   .geoip_databases          8mULwHuiQCCNXcB8fzvEAQ   1   0          3            0      2.6mb          2.6mb
green  open   .geoip_databases_restored 8aHXyYzFQ6yhkUmQC0EwYw   1   0         40            0     38.4mb         38.4mb
```

5. Восстановление

`curl -X POST localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty -H 'Content-Type: application/json' -d'{"include_global_state":true}'`




