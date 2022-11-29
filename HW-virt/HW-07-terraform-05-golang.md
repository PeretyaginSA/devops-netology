# Домашнее задание к занятию "7.5. Основы golang"

С golang в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. Но рекомендуем ознакомиться с GoLand.

## Задача 1. Установите golang.

1.Воспользуйтесь инструкций с официального сайта: https://golang.org/.
2.Так же для тестирования кода можно использовать песочницу: https://play.golang.org/.

```
PS > go version
go version go1.19.3 windows/amd64
```

## Задача 2. Знакомство с gotour.

У Golang есть обучающая интерактивная консоль https://tour.golang.org/. Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.

## Задача 3. Написание кода.

Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода на своем компьютере, либо использовать песочницу: https://play.golang.org/.

1.Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:

```
package main

import "fmt"

func main() {
    fmt.Print("Enter a number: ")
    var input float64
    fmt.Scanf("%f", &input)

    output := input * 2

    fmt.Println(output)    
}
```

***Ответ:***

```go
package main

import "fmt"

func main() {
	fmt.Print("Enter the value in meters: ")
	var input float64
	fmt.Scanf("%f", &input)

	output := input / 0.3048

	fmt.Println("pl.feet =", output)
}

Enter the value in meters: 3
pl.feet = 9.84251968503937
```

2.Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

```
x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}`
```


```go
package main

import "fmt"

func main() {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	c := 0
	for i, v := range x {
		if i == 0 {
			c = v
		} else {
			if v < c {
				c = v
			}
		}
	}
	fmt.Println(c)
}

= 9
```

3.Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

```go
package main

import "fmt"

func list() (c []int) {
	for i := 1; i <= 100; i++ {
		if i%3 == 0 {
			c = append(c, i)
		}
	}
	return
}

func main() {
	v := list()
	fmt.Printf("%v", v)
}

= 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 96 99
```

В виде решения ссылку на код или сам код.