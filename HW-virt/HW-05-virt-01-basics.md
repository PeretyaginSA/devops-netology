# Домашнее задание к занятию "5.1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."

## Задача 1
Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

***Ответ:***

- Аппаратная виртуализация:<br> 
  \- *При полной виртуализации гостевая ОС полностью изолирована виртуальной машиной от уровня виртуализации и аппаратного обеспечени*

- Паравиртуализации виртуализация:<br>
  \- *гостевые ОС специально подготавливаются для исполнения в виртуализированной среде, для чего их ядро незначительно модифицируется, гостевая ОС взаимодействует с гипервизором через специальный API*


- Виртуализации на основе ОС:<br>
  \- *в операционной системы не существует отдельного гипервизора. Вместо этого сама хостовая операционная система отвечает за разделение аппаратных ресурсов между несколькими виртуальными машинами*

## Задача 2
Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

### Организация серверов:

* физические сервера,
* паравиртуализация,
* виртуализация уровня ОС.

Условия использования:

* Высоконагруженная база данных, чувствительная к отказу.
* Различные web-приложения.
* Windows системы для использования бухгалтерским отделом.
* Системы, выполняющие высокопроизводительные расчеты на GPU.

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

***Ответ:***

* Высоконагруженная база данных, чувствительная к отказу.<br>
  \- *Физические сервера, кластер при помощи СУБД*

* Различные web-приложения.<br>
  \- *Виртуализация уровня ОС. Docker легче масштабировать и развертывать*

* Windows системы для использования бухгалтерским отделом.<br>
  \- *Паравиртуализация. Для простоты обслуживания. К примеру Hyper-V*

* Системы, выполняющие высокопроизводительные расчеты на GPU.<br>
  \- *Физические сервера. Для получения максимума от GPU*




## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

### Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2.  Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.



***Ответ:***

1. VMWare или Hyper-V т.к. преимущественно Windows based инфраструктура
2. Xen подойдёт для Linux и Windows
3. Hyper-V, максимальнуя совместимость с Windows
4. LXC и Docker создание контейнеров для тестирования


## Задача 4
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

***Ответ:***

* Недостатки гетерогенной среды:<br>
\- сложность администрирования<br>
\- повышенный риск отказа<br>
\- повышенние стоимости обслуживания<br>

* Необходимо постоянное сопровождение/тестирование инфраструктуры, автоматизация развертывания ВМ

* В теории лучше однородная среда, но на практике все иначе.
