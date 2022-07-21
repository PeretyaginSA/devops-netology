1. Создал Unit-файл 
sudo nano /lib/systemd/system/node_exporter.service

[Unit]
Description=node_exporter

[Service]
ExecStart=/usr/local/bin/node_exporter/node_exporter $TEST
!!!!!!!!! EnvironmentFile=/etc/default/node_exporter т.е. здесь мы можем задать переменную $TEST="-a -h" и передать её в node_exporter
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

4. На физической машине не было возможности проверить.
В vagrand'е отображается как 'KVM'
vagrant@vagrant:~$  dmesg | grep "Hypervisor detected"
[    0.000000] Hypervisor detected: KVM
в VMware отображается один в один 
0.000000] Hypervisor detected: VMware

5. sysctl fs.nr_open выдает = 1048576
   или cat /proc/sys/fs/nr_open выдает 1048576,
fs nr_open - максимальное количество файлов, которое может быть выделено одним процессом.
Максимальное количество файловых дескрипторов, поддерживаемых ядром, 
то есть максимальное количество файловых дескрипторов, используемых процессом

При помощи ulimit можно ограничть ресурсы оболочки. Она обеспечивает контроль над ресурсами, 
доступными оболочке, и процессами, которые она создает
-S использует `мягкий" лимит ресурсов
-H использовать `жесткий" лимит ресурсов
-n максимальное количество открытых файловых дескрипторов

6. 
sudo -i 
unshare -f --pid --mount-proc /usr/bin/sleep 1h & 
root@vagrant:~# ps
    PID TTY          TIME CMD
   1570 pts/1    00:00:00 sudo
   1571 pts/1    00:00:00 bash
   1583 pts/1    00:00:00 unshare
   1584 pts/1    00:00:00 sleep
   1585 pts/1    00:00:00 ps

nsenter --target 1584 --pid --mount
root@vagrant:/# ps
    PID TTY          TIME CMD
      1 pts/1    00:00:00 sleep
      2 pts/1    00:00:00 bash
     13 pts/1    00:00:00 ps

7. fork bomb

:()         # Определяет функцию ":". Это не требует никаких аргументов.
{ ... };    # Тело функции.
:           # Вызовите функцию ":", которая только что была определена.

стабилизироваться помог: cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-5.scope

Cgroups - это способ ограничить ресурсы процессов внутри конкретной cgroup

ulimit -a

vagrant@vagrant:~$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 7580
max locked memory       (kbytes, -l) 65536
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 7580  -----------  максимальное количество процессов
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

ulimit -u можно уменьшить количество процессов
