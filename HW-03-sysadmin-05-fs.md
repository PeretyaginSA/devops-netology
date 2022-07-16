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


8.  




