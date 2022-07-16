1.


2.



3. Выполнено


![image](https://user-images.githubusercontent.com/106968319/179356454-c983e592-6835-4b31-b7c4-9051e577218c.png)




4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.


![image](https://user-images.githubusercontent.com/106968319/179359013-bf51234b-8c7c-43a2-aa4d-5834e9077488.png)


5. Используя sfdisk, перенесите данную таблицу разделов на второй диск.


 sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc

![image](https://user-images.githubusercontent.com/106968319/179359336-acb49fa8-976a-4e11-9551-50af66a0415d.png)


6. Соберите mdadm RAID1 на паре разделов 2 Гб.

sudo mdadm --create --verbose /dev/md1 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1


![image](https://user-images.githubusercontent.com/106968319/179360860-be08586b-6d0c-4483-9be4-a61a3fc77ba6.png)



7. Соберите mdadm RAID0 на второй паре маленьких разделов.

sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2



![image](https://user-images.githubusercontent.com/106968319/179361279-202ed6e2-eeeb-4d15-ae03-731bfc44894e.png)


8. Создайте 2 независимых PV на получившихся md-устройствах.

sudo pvcreate /dev/md0
sudo pvcreate /dev/md1


![image](https://user-images.githubusercontent.com/106968319/179361458-2498add0-8579-47cf-9177-c3fc433ec227.png)


9. Создайте общую volume-group на этих двух PV.

vgcreate vg01 /dev/md0 /dev/md1


![image](https://user-images.githubusercontent.com/106968319/179362537-c509c4af-e146-40e0-941b-bfaec932f110.png)


10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

sudo lvcreate -L 100M -n ln_vg01 vg01 /dev/md0



![image](https://user-images.githubusercontent.com/106968319/179367089-7892443f-26a3-4db0-b55b-068beba58de4.png)


11. Создайте mkfs.ext4 ФС на получившемся LV.

mkfs.ext4 /dev/vg01/ln_vg01


![image](https://user-images.githubusercontent.com/106968319/179367149-b9597cda-a26b-47eb-ae60-656784e64c51.png)


12. Смонтируйте этот раздел в любую директорию, например, /tmp/new.

mkdir /tmp/new
sudo mount /dev/vg01/ln_vg01 /tmp/new/


![image](https://user-images.githubusercontent.com/106968319/179367341-b39bdc13-1599-42a4-94e5-e36143481d67.png)


13. Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

Выполнено


![image](https://user-images.githubusercontent.com/106968319/179367526-83260f11-9e14-45fd-b574-8a5cc0393606.png)



14. Прикрепите вывод lsblk.


![image](https://user-images.githubusercontent.com/106968319/179367568-87a98751-6975-4095-8919-33ac1c61297b.png)



15. 

















