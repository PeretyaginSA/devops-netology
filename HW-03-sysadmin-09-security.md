1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

Выполнено

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

С Google authenticator знаком
Выполнено


3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

Установил apatch2 - sudo apt install apache2

Включил SSL - sudo a2enmod ssl

Создал SSL-сертификат - 
openssl req -x509 -nodes -days 365 -newkey rsa:2048
-keyout /etc/ssl/private/ssl-cert-snakeoil.key
-out /etc/ssl/certs/ssl-cert-snakeoil.pem 
-subj "/C=RU/ST=Moscow/L=Moscow/O=Netology/OU=DevOps20/CN=localhost"
 
Настроил Apache для использования SSL - 

sudo nano /etc/apache2/sites-available/localhost.conf
 
<VirtualHost *:443>
   ServerName localhost
   DocumentRoot /var/www/localhost

   SSLEngine on
   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost> 
 
Создал тестовый сайт - sudo nano /var/www/localhost/index.html `<h1>it worked!</h1>`
 
![image](https://user-images.githubusercontent.com/106968319/181581083-1a33acdd-ba55-462e-b580-b5bc36de3c1d.png)




4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

Использовал testssl.sh на ya.ru

![image](https://user-images.githubusercontent.com/106968319/181583797-28de219b-c090-4f39-bfe6-18882a8629ac.png)



5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

Установил ssh сервер - sudo apt install openssh-server

Сгенерировал кльч - ssh-keygen

Your identification has been saved in /home/vagrant/.ssh/id_rsa
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:o71TEwz+5cHdcwAKIfuUuPagH+Bm9n7fFl4vl+bG20Q vagrant@vagrant
The key's randomart image is:
+---[RSA 3072]----+
|    . o.  ..     |
|     + o..  .    |
|    o o..o + .   |
|     +  . o B .  |
|    = . T. + +  E|
|   o = o .+ o .. |
|    * + .. o o..o|
|   + o .o. .o .*+|
|     .+..o... +=o|
+----[SHA256]-----+


Скопировал ключ а удаленный сервер - ssh-copy-id peretyaginsa@192.168.30.100

Подключился - ssh peretyaginsa@192.168.30.100 и ввел пароль
Number of key(s) added: 1
Последующие подключение уже без пароля

6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

cd ~/.ssh/

mv id_rsa mykey_rsa
mv id_rsa.pub mykey_rsa.pub

nano config
Host devops
HostName 192.168.30.100
IdentityFile ~/.ssh/mykey_rsa
User peretyaginsa
Port 22

Затем - ssh devops

![image](https://user-images.githubusercontent.com/106968319/181610437-eeecdce7-347a-4d43-8806-1710aa9bb741.png)


7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.













