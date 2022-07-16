1.


2.



3. Выполнено


![image](https://user-images.githubusercontent.com/106968319/179356454-c983e592-6835-4b31-b7c4-9051e577218c.png)




4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.


![image](https://user-images.githubusercontent.com/106968319/179359013-bf51234b-8c7c-43a2-aa4d-5834e9077488.png)


5. Используя sfdisk, перенесите данную таблицу разделов на второй диск.
 sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc

![image](https://user-images.githubusercontent.com/106968319/179359336-acb49fa8-976a-4e11-9551-50af66a0415d.png)




