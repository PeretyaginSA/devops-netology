# Домашнее задание к занятию "6.2. SQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

```bash
docker run \
-e POSTGRES_PASSWORD=postgres \
-p 5432:5432 \
-v /home/ubuntu/hw_sql/pg_db/:/var/lib/postgresql/data \
-v /home/ubuntu/hw_sql/pg_backup/:/var/lib/postgresql/ \
-d postgres:12
```

## Задача 2

В БД из задачи 1:

+ создайте пользователя test-admin-user и БД test_db
+ в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
+ предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
+ создайте пользователя test-simple-user
+ предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:

+ id (serial primary key)
+ наименование (string)
+ цена (integer)

Таблица clients:

+ id (serial primary key)
+ фамилия (string)
+ страна проживания (string, index)
+ заказ (foreign key orders)

**Приведите:**

+ итоговый список БД после выполнения пунктов выше,
```bash
test_db=# \l
                                     List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |       Access privileges        
-----------+----------+----------+------------+------------+--------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres                  +
           |          |          |            |            | postgres=CTc/postgres         +
           |          |          |            |            | "test-admin-user"=CTc/postgres
(4 rows)
```

+ описание таблиц (describe)
```bash
test_db=# \d orders
                                    Table "public.orders"
    Column    |       Type        | Collation | Nullable |              Default               
--------------+-------------------+-----------+----------+------------------------------------
 id           | integer           |           | not null | nextval('orders_id_seq'::regclass)
 наименование | character varying |           |          | 
 цена         | integer           |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```
```bash
test_db=# \d clients
                                       Table "public.clients"
      Column       |       Type        | Collation | Nullable |               Default               
-------------------+-------------------+-----------+----------+-------------------------------------
 id                | integer           |           | not null | nextval('clients_id_seq'::regclass)
 фамилия           | character varying |           |          | 
 страна проживания | character varying |           |          | 
 заказ             | integer           |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```

+ SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
SELECT * FROM information_schema.table_privileges
WHERE grantee in ('test-admin-user', 'test-simple-user')
ORDER BY grantee;
```

+ список пользователей с правами над таблицами test_db

```bash
test_db=# SELECT * FROM information_schema.table_privileges
WHERE grantee in ('test-admin-user', 'test-simple-user')
ORDER BY grantee;
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
(22 rows)
```


## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders:


Наименование | цена
|---|---|      
Шоколад	| 10 
Принтер	| 3000
Книга 	| 500
Монитор	| 7000
Гитара	| 4000

Таблица clients:

ФИО |	Страна проживания
|---|---| 
Иванов Иван Иванович | USA
Петров Петр Петрович | Canada
Иоганн Себастьян Бах | Japan
Ронни Джеймс Дио	   | Russia
Ritchie Blackmore 	 | Russia

Используя SQL синтаксис:

+ вычислите количество записей для каждой таблицы
+ приведите в ответе:
  + запросы
  + результаты их выполнения.

***Ответ:***
```bash
test_db=# SELECT * FROM orders;
 id | наименование | цена 
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
(5 rows)
```
```bash
test_db=# SELECT COUNT(*) FROM orders;
 count 
-------
     5
(1 row)
```







```bash
test_db=# SELECT * FROM clients;
 id |       фамилия        | страна проживания | заказ 
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |      
  2 | Петров Петр Петрович | Canada            |      
  3 | Иоганн Себастьян Бах | Japan             |      
  4 | Ронни Джеймс Дио     | Russia            |      
  5 | Ritchie Blackmore    | Russia            |      
(5 rows)
```
```bash
test_db=# SELECT COUNT(*) FROM clients;
 count 
-------
     5
(1 row)
```



## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

ФИО	| Заказ
|---|---|
Иванов Иван Иванович |	Книга
Петров Петр Петрович |	Монитор
Иоганн Себастьян Бах |	Гитара


Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

Подсказка - используйте директиву `UPDATE`.




***Ответ:***
```sql
update clients
set заказ = 3
where id  = 1
```
```sql
update clients
set заказ = 4
where id  = 2
```
```sql
update clients
set заказ = 5
where id  = 3
```
```sql
test_db=# SELECT c.фамилия, o.наименование "заказ"
FROM  clients c, orders o
WHERE o.id = c.заказ;
       фамилия        |  заказ  
----------------------+---------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
(3 rows)
```


## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.


***Ответ:***


```sql
test_db=# EXPLAIN (analyze)
SELECT c.фамилия, o.наименование "заказ"
FROM  clients c, orders o
WHERE o.id = c.заказ;
                                                    QUERY PLAN                                                     
-------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=64) (actual time=0.037..0.039 rows=3 loops=1)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=36) (actual time=0.007..0.008 rows=5 loops=1)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=36) (actual time=0.008..0.008 rows=5 loops=1)
         Buckets: 2048  Batches: 1  Memory Usage: 17kB
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=36) (actual time=0.005..0.005 rows=5 loops=1)
 Planning Time: 0.143 ms
 Execution Time: 0.079 ms
(8 rows)
```
EXPLAIN - это инструмент  для оптимизации запросов. EXPLAIN выводит информацию, необходимую для понимания, что же делает ядро PostgreSQL при каждом конкретном запросе.<br>
**Seq Scan** — последовательное, блок за блоком, чтение данных таблицы
**cost** - это абстрактное понятие, призванное оценить затратность операции. Первое значение 0.00 — затраты на получение первой строки. Второе — 18334.00 — затраты на получение всех строк.<br>
**rows** — приблизительное количество возвращаемых строк при выполнении операции Seq Scan. Это значение возвращает планировщик.<br>
**width** — средний размер одной строки в байтах.<br>
**actual time** — реальное время в миллисекундах, затраченное для получения первой строки и всех строк соответственно.<br>
**rows** — реальное количество строк, полученных при Seq Scan.<br>
**loops** — сколько раз пришлось выполнить операцию Seq Scan.<br>
**Total runtime** — общее время выполнения запроса.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.



***Ответ:***
- Создание бэкапа
`root@c3b1be1f0d6c:/# pg_dump -U postgres test_db > /var/lib/postgresql/test_db.backup`

```bash
root@ubuntu-virtual-machine:/# la /home/ubuntu/hw_sql/pg_backup/
test_db.backup
```

- Остановка контейнера
```bash
root@ubuntu-virtual-machine:/home/ubuntu# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED       STATUS       PORTS                                       NAMES
c3b1be1f0d6c   postgres:12   "docker-entrypoint.s…"   6 hours ago   Up 6 hours   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   ecstatic_mestorf
root@ubuntu-virtual-machine:/home/ubuntu# docker stop ecstatic_mestorf
ecstatic_mestorf
root@ubuntu-virtual-machine:/home/ubuntu# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@ubuntu-virtual-machine:/home/ubuntu#
```

- Новый пустой контейнер с PostgreSQL

```bash
docker run \
-e POSTGRES_PASSWORD=postgres \
-p 5432:5432 \
-v /home/ubuntu/hw_sql/pg_backup/:/var/lib/postgresql/ \
-d postgres:12
```

- Восстановите БД test_db

```bash
root@d4409461b66f:/var/lib/postgresql# psql -U postgres test_db < ./test_db.backup
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval 
--------
      5
(1 row)

 setval 
--------
      5
(1 row)

ALTER TABLE
ALTER TABLE
ALTER TABLE
root@d4409461b66f:/var/lib/postgresql# 
```
