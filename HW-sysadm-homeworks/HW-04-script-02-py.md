# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | Ошибка типа. нельзя сложить число и строку  |
| Как получить для переменной `c` значение 12? | a = 1; b = '2'; c = str(a) + b  |
| Как получить для переменной `c` значение 3?  | a = 1; b = '2'; c = a + int(b)  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        os.chdir(r"/home/peretyaginsa/sysadm-homeworks")
        print(os.getcwd() + '/' + prepare_result)
	

```

### Вывод скрипта при запуске при тестировании:
```
/home/peretyaginsa/sysadm-homeworks/04-script-02-py/README.md
/home/peretyaginsa/sysadm-homeworks/README.md
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

prepare_result=''

if len(sys.argv) < 2:
	print('СКРИПТ ЗАПУЩЕН БЕЗ АРГУМЕНТОВ, ИСПОЛЬЗУЕТСЯ ЛОКАЛЬНАЯ ДИРЕКТОРИЯ')
	if not os.path.isdir(os.getcwd() + '/.git'):
		print('НЕ ЯВЛЯЕТСЯ РЕПОЗИТОРИЕМ GIT!')
		exit()
	else:
		bash_command = ["git status"]
		result_os = os.popen(bash_command[0]).read()
		for result in result_os.split('\n'):
			if result.find('modified') != -1:
				prepare_result = result.replace('\tmodified:   ', '')
				print(os.getcwd() + '/' + prepare_result)
else:
	if not os.path.isdir(sys.argv[1] + '/.git'):
		print('НЕ ЯВЛЯЕТСЯ РЕПОЗИТОРИЕМ GIT!')
		exit()
	else:
		bash_command = ["cd " + sys.argv[1], "git status"]
		result_os = os.popen(' && '.join(bash_command)).read()
		for result in result_os.split('\n'):
			if result.find('modified') != -1: 
				prepare_result = result.replace('\tmodified:   ', '') 
				print(os.getcwd() + '/' + sys.argv[1] + '/' + prepare_result)		
		if prepare_result == '':
				print('ИЗМЕНЕНИЙ НЕ НАЙДЕНО')

```

### Вывод скрипта при запуске при тестировании:
```
peretyaginsa@bhdevops:~$ ./my2.py                   # Локальная директория
СКРИПТ ЗАПУЩЕН БЕЗ АРГУМЕНТОВ, ИСПОЛЬЗУЕТСЯ ЛОКАЛЬНАЯ ДИРЕКТОРИЯ
НЕ ЯВЛЯЕТСЯ РЕПОЗИТОРИЕМ GIT!
peretyaginsa@bhdevops:~$ ./my2.py test              # Обычныя директория
НЕ ЯВЛЯЕТСЯ РЕПОЗИТОРИЕМ GIT!
peretyaginsa@bhdevops:~$ ./my2.py sysadm-homeworks  # Репозиторий git с модификациями
/home/peretyaginsa/sysadm-homeworks/04-script-02-py/README.md
/home/peretyaginsa/sysadm-homeworks/README.md
peretyaginsa@bhdevops:~$ ./my2.py devops-netology   # Репозиторий git без модификаций
ИЗМЕНЕНИЙ НЕ НАЙДЕНО
```

## Обязательная задача 4
Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
from time import sleep


i = 0

sites = {'drive.google.com' : '0.0.0.0', 'mail.google.com' : '0.0.0.0', 'google.com' : '0.0.0.0'}

while i <=5 :
    for site,ip in sites.items():
        ip_addr = socket.gethostbyname(site)
        if ip != ip_addr:
            sites.update({site:ip_addr})
            print('[ERROR] '+site+ ' IP mismatch: ' +ip+ ' '+ip_addr)
        else:
            print(site+' - '+ip)

    sleep(3)
    i += 1
```

### Вывод скрипта при запуске при тестировании:
```
[ERROR] drive.google.com IP mismatch: 0.0.0.0 74.125.205.194
[ERROR] mail.google.com IP mismatch: 0.0.0.0 209.85.233.17
[ERROR] google.com IP mismatch: 0.0.0.0 173.194.222.138
drive.google.com - 74.125.205.194
mail.google.com - 209.85.233.17
[ERROR] google.com IP mismatch: 173.194.222.138 173.194.222.113
drive.google.com - 74.125.205.194
mail.google.com - 209.85.233.17
[ERROR] google.com IP mismatch: 173.194.222.113 173.194.222.139
drive.google.com - 74.125.205.194
[ERROR] mail.google.com IP mismatch: 209.85.233.17 209.85.233.83
[ERROR] google.com IP mismatch: 173.194.222.139 173.194.222.100
drive.google.com - 74.125.205.194
[ERROR] mail.google.com IP mismatch: 209.85.233.83 209.85.233.19
[ERROR] google.com IP mismatch: 173.194.222.100 173.194.222.102
drive.google.com - 74.125.205.194
[ERROR] mail.google.com IP mismatch: 209.85.233.19 209.85.233.17
[ERROR] google.com IP mismatch: 173.194.222.102 173.194.222.101
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```
