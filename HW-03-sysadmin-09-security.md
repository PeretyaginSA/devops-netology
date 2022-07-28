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



5. 
