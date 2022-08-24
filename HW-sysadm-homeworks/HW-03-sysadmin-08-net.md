1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

Подключился, посмотрел таблицу маршрутизации



2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

ip link add dummy0 type dummy

ip addr add 192.168.255.1 dev dummy0

ip link set dummy0 up




ip route add 172.16.1.0/24 via 192.168.255.1

ip route add 172.16.100.0/24 via 10.0.2.2


![image](https://user-images.githubusercontent.com/106968319/179396251-672d5042-22af-42aa-bc6f-d8e93a36e0ce.png)



3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

netstat -tna

![image](https://user-images.githubusercontent.com/106968319/179396789-9b3cf293-3e25-403f-ab57-3a80b71e73a7.png)

используются - ssh- 22 и dns- 53



4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

netstat -uan


![image](https://user-images.githubusercontent.com/106968319/179396958-1d1cf0f9-43cf-4b7a-a047-c60ca3f0f67e.png)


используются - dns- 53 и dhcp (bootpc) - 68




5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.


![image](https://user-images.githubusercontent.com/106968319/179398882-dbc7c717-83e0-4fcc-8121-f3934a40a765.png)

