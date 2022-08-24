1. Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80 
отправьте HTTP запрос


Действительно неправильно вводил параметры

301 Moved Permanently- Ресурс перемещен навсегдаю. Документ уже не используется сервером, а ссылка перенаправляет на другую страницу

vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.129.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
x-request-guid: 22e81d7a-8092-4c04-8aed-8a440e69e06e
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Thu, 21 Jul 2022 15:25:45 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-lin2290031-LIN
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1658417146.598715,VS0,VE104
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=eb793f23-ff2d-ab90-9179-49cd2b2db900; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Connection closed by foreign host.

2. Повторите задание 1 в браузере, используя консоль разработчика F12.

Status Code: 307 Internal Redirect - Редирект на https

![image](https://user-images.githubusercontent.com/106968319/179388147-9d52131a-f987-4cd6-9b60-5b7cccc61bc0.png)

дольше всего обрабатывался запрос с кодом 200 (успешный запрос) 811ms

![image](https://user-images.githubusercontent.com/106968319/179388223-df19741f-64c4-4747-8a26-69847208ee71.png)

3. Какой IP адрес у вас в интернете?

Использовал 2ip.ru

4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

Зная свой ip, используя утилиту whois, увидел имя провайдера и номер автономной системы которую он использует


5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute

traceroute -An 8.8.8.8

![image](https://user-images.githubusercontent.com/106968319/179388693-3de5c8b8-b327-4c11-a948-a6a917b1f377.png)


6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?

mtr -zn 8.8.8.8


![image](https://user-images.githubusercontent.com/106968319/179389009-82d3ab97-da9f-4afe-9e79-9550b5b8cd5e.png)

наибольшая задержка на 9 хопе


7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig

dig NS dns.google

![image](https://user-images.githubusercontent.com/106968319/179389426-9e808925-678d-4301-bae7-c1a2b887faec.png)


dig A dns.google

![image](https://user-images.githubusercontent.com/106968319/179389439-7fd4c7f3-3b26-4aad-bf44-df0f27e14c99.png)


8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig

dig -x 8.8.8.8

![image](https://user-images.githubusercontent.com/106968319/179389694-e8a3c001-0201-4a18-8fd8-2601c7c11324.png)


