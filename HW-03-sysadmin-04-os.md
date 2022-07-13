1. Создал Unit-файл 
sudo nano /lib/systemd/system/node_exporter.service

[Unit]
Description=node_exporter

[Service]
ExecStart=/usr/local/bin/node_exporter/node_exporter
EnvironmentFile=/etc/default/node_exporter
Type=simple

[Install]
WantedBy=multi-user.target

перезагрузил службы systemctl daemon-reload
добавил в автозапуск службу systemctl enable node_exporter
и перезагрузил systemctl restart node_exporter

vagrant@vagrant:~$ systemctl status node_exporter.service

● node_exporter.service - node_exporter
     Loaded: loaded (/lib/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-07-13 11:39:30 UTC; 3s ago
   Main PID: 7079 (node_exporter)
      Tasks: 4 (limit: 2274)
     Memory: 2.3M
     CGroup: /system.slice/node_exporter.service
             └─7079 /usr/local/bin/node_exporter/node_exporter

ребутнул машину, после загрузки служба была автоматически запущина
			 
● node_exporter.service - node_exporter
     Loaded: loaded (/lib/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-07-13 11:41:46 UTC; 47s ago
   Main PID: 651 (node_exporter)
      Tasks: 4 (limit: 2274)
     Memory: 13.4M
     CGroup: /system.slice/node_exporter.service
             └─651 /usr/local/bin/node_exporter/node_exporter

2. Использовал curl -s localhost:9100/metrics | grep ...

node_cpu_seconds_total
process_cpu_seconds_total

node_memory_MemAvailable_bytes
node_memory_MemFree_bytes

node_network_receive_bytes_total   
node_network_transmit_bytes_total

node_disk_io_time_seconds_total
node_disk_read_bytes_total
node_disk_written_bytes_total

3. Выполнено

![image](https://user-images.githubusercontent.com/106968319/178814506-e571a77f-ad1f-47fd-b948-c4837fada9b2.png)

4. Использовал dmesg | grep "Hypervisor detected"
[    0.000000] Hypervisor detected: KVM















