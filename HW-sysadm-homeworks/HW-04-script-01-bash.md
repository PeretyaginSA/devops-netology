# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`           |     a+b       | без $ будет считаться строкой                                  |
| `d`           |     1+2       | подставятся значения аргументов, но всеравно останется стракой |
| `e`           |      3        | значения в () будут расценены как математические               |


## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash

while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
#!/bin/bash

while ((1==1)) # добавлена ")"
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	break  # Завершение работы цикла
	fi
done
```

## Обязательная задача 3
Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
#!/bin/bash

ip=(192.168.0.1 173.194.222.113 87.250.250.242)

for h in ${ip[@]}
do
	for ((i=1; i < 6; i++))
	do
		nc -zvw 1 $h 80
	echo $(date) $h port 80 open >> /home/ubuntu/DevOps-20/host.log

	done
done
```
## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
#!/bin/bash

ip=(192.168.0.1 173.194.222.113 87.250.250.242)

while ((1==1))
do
	for h in ${ip[@]}
	do
		nc -zvw 1 $h 80	
	if (($? == 0))
	then
		echo $(date) $h port 80 open >> /home/ubuntu/DevOps-20/host.log
	elif (($? != 0))
	then
		echo $(date) $h port 80 close >> /home/ubuntu/DevOps-20/err.log && exit
	
	fi
	
	done
done
```
