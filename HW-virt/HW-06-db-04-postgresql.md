# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1
Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

+ вывода списка БД
+ подключения к БД
+ вывода списка таблиц
+ вывода описания содержимого таблиц
+ выхода из psql



***Ответ:***

```bash
docker run \
--name test_pg \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=test_database \
-p 5432:5432 \
-v /home/ubuntu/hw_sql/pg_db/:/var/lib/postgresql/data \
-v /home/ubuntu/hw_sql/pg_backup/:/backup/ \
-d postgres:13
```

+ вывода списка БД<br>
`\l`
+ подключения к БД<br>
`\c`
+ вывода списка таблиц<br>
`\dt` `\dt[S+]`
+ вывода описания содержимого таблиц<br>
`\d`
+ выхода из psql<br>
`\q`


## Задача 2
Используя `psql` создайте БД `test_database`.

Изучите бэкап БД.

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу `pg_stats`, найдите столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.


***Ответ:***

+ Восстановление бэкапа
```bash
root@7f7313040e36:/# psql -U postgres test_database < backup/test_dump.sql
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
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)
```

+ ANALYZE

```bash
test_database=# ANALYZE VERBOSE orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
```

+ `pg_stats`

```bash
test_database=# SELECT max(avg_width) FROM pg_stats WHERE tablename = 'orders';
 max 
-----
  16
(1 row)
```



## Задача 3


Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время.
Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение
таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?





***Ответ:***

```bash
test_database=# CREATE TABLE orders_1 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_1 SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# CREATE TABLE orders_2 (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_2 SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
```

```sql
test_database=# select * from public.orders_1;
 id |       title        | price 
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)
```
```sql
test_database=# select * from public.orders_2;
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

Да, если изначально подготовить таблицу к партиционированию


## Задача 4
Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?


***Ответ:***


`pg_dump -U postgres test_database > /backup/dump_test_database.sql`

```sql
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL UNIQUE,
    price integer DEFAULT 0
```



