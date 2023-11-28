## Задание 1

1. Изучил код для создания ВМ с помощью remote-модуля
2. Создал ВМ одну ВМ, используя этот модуль. Для этого необходимо скорректировать переменную *instance_count* на 1:
![screenshot](/screenshots/1-2.png)
В файле cloud-init.yml использую переменную для ssh-ключа вместо хардкода:
![screenshot](/screenshots/2-12.png)
 Передаю ssh-ключ в функцию template_file в блоке vars={}, так как переменная является списком использую значение индекса 0 - первый элемент списка:
 
![screenshot](/screenshots/2-13.png)
![screenshot](/screenshots/2-14.png)
3. Для добавления в файл cloud-init.yml установки nginx, необходимо добавить в packages:
```
...
packages:

- vim

- nginx
...
```
