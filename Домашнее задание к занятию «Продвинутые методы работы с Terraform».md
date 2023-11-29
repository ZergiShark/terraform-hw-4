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
4. Предоставляю скриншот подключения к консоли и вывод команды `sudo nginx -t`:
![screenshot](/screenshots/1-4.png)
## Задание 2

1. Написал локальный модуль vpc, который будет создавать 2 ресурса: одну сеть и одну подсеть в зоне, объявленной при вызове модуля:
![screenshot](/screenshots/2-2.png)
2. Передаю в модуль переменные с названием сети, zone и v4_cidr_blocks:
![screenshot](/screenshots/2-1.png)
3. Модуль возвращает в root module с помощью output информацию о yandex_vpc_subnet. Cкриншот информации из terraform console о моём модуле:

![screenshot](/screenshots/2-4.png)

4. Заменяю ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем:
```
module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_hw.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [module.vpc_hw.subnet_id]
  instance_name   = "web"
  instance_count  = 1
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }
```
Передаю необходимые параметры сети из модуля vpc в модуль с виртуальной машиной
```
output "dev_network_id" {
  value = module.vpc_hw.network_id
}

output "dev_subnet_id" {
  value = module.vpc_hw.subnet_id
}
```
5. Предоставляю скриншот содержимого модуля:

![screenshot](/screenshots/2-5.png)
7. Сгенерировал документацию к модулю с помощью terraform-docs [ТЫК](/vpc/vpc-doc.md)

## Задание 3

1. Вывожу список ресурсов в стейте:
![screenshot](/screenshots/state.png)
2. Полностью удаляю из стейта модуль vpc:
![screenshot](/screenshots/state-rm.png)
3. Полностью удалил из стейта модуль vm:


![screenshot](/screenshots/state-rm-vm.png)
5. Импортирую всё обратно:


![screenshot](/screenshots/vm.png)


![screenshot](/screenshots/subnet.png)
Изменений нет

