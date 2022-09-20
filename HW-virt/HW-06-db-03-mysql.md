# Домашнее задание к занятию "6.3. MySQL"

## Задача 1
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.

***Ответ:***

```bash
docker run \
--name test_mysql \
-e MYSQL_ROOT_PASSWORD=mysql \
-p 3306:3306 \
-v /home/ubuntu/hw_sql/mysql_backup/:/backup/ \
-d mysql:8
```

`docker exec -it test_mysql bash`<br>
`mysql -u root -p`<br>
`create database test_db`<br>
`mysql -u root -p test_db < /backup/test_dump.sql`<br>
`use test_db`

```sql
mysql> \s
--------------
mysql  Ver 8.0.30 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		19
Current database:	test_db
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.30 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			1 hour 28 min 43 sec

Threads: 2  Questions: 102  Slow queries: 0  Opens: 164  Flush tables: 3  Open tables: 82  Queries per second avg: 0.019
--------------
```

```sql
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```

```sql
mysql> select *
    -> from orders
    -> where price > 300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)
```


## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:

+ плагин авторизации mysql_native_password
+ срок истечения пароля - 180 дней
+ количество попыток авторизации - 3
+ максимальное количество запросов в час - 100
+ аттрибуты пользователя:
  + Фамилия "Pretty"
  + Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и **приведите в ответе к задаче**.

***Ответ:***

```bash
CREATE USER 'test'@'localhost'
	IDENTIFIED WITH mysql_native_password BY 'test-pass'
	WITH MAX_CONNECTIONS_PER_HOUR 100
	PASSWORD EXPIRE INTERVAL 180 DAY
	FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME UNBOUNDED
	ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
GRANT SELECT 
	ON test_db.* 
	TO 'test'@'localhost';
 ```
 
 
```sql
mysql> SELECT *
    -> FROM INFORMATION_SCHEMA.USER_ATTRIBUTES;
+------------------+-----------+---------------------------------------+
| USER             | HOST      | ATTRIBUTE                             |
+------------------+-----------+---------------------------------------+
| root             | %         | NULL                                  |
| mysql.infoschema | localhost | NULL                                  |
| mysql.session    | localhost | NULL                                  |
| mysql.sys        | localhost | NULL                                  |
| root             | localhost | NULL                                  |
| test             | localhost | {"fname": "James", "lname": "Pretty"} |
+------------------+-----------+---------------------------------------+
6 rows in set (0.00 sec)
```



## Задача 3

Установите профилирование `SET profiling = 1`. Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:

+ на `MyISAM`
+ на `InnoDB`




## Задача 4

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

+ Скорость IO важнее сохранности данных
+ Нужна компрессия таблиц для экономии места на диске
+ Размер буффера с незакомиченными транзакциями 1 Мб
+ Буффер кеширования 30% от ОЗУ
+ Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.
















