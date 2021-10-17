# ДЗ по теме Nginx - балансировка и отказоустойчивость 2

## Описание стенда
Prerequisites:
устновленные git, terraform, ansible, yc

Стенд состоит из двух частей:
Первая часть это запуск инфрасруктуры с помощью yandex cloud. Находится в папке terraform.
Вторая часть это установка и запуск сервера nginx на подготовленном сервере с помощью ansible. Находится в папке ansible.


В папке terraform написан код для развёртывания ВМ в облаке yandex.
Terraform состоит из следующих файлов:
```
main.tf - описание провайдера
balance.tf - описание узлов для балансировщиков
db.tf - описание узлов для СУБД
vpc.tf - описание сети
web.tf - описание web серверов
outputs.tf - вывод IP ВМ,  создание динамического inventory для ansible, создание файлов hosts используемых ansible и конфигурационного файла keealived
terraform.tfvars - присвоение значений переменным, которое не публикуется на git исходя из соображений безопасности.
Вместо него можно ознакомится с файлом terraform.tfvars.example
default_server.conf.tmpl - темплейт для формирование динамического конфигурационного файла keepalived
inventory.tmpl - темплейт для формирование динамического inventory для ansible
hosts.tmpl - темплейт для формирование динамическмх файлов hosts используемых ansible
variables.tf - объявление переменных
```

Вторая часть состоит из пьесы `setup_balance.yml`, которая запускает роли `db` `lb` и `web`
В роли `db` устанавливается и настраивается mariadb-server
В роли `lb` устанавливается и настраивается keeepalived и nginx load balancer. Балансировка настраивается по внутреннему IP т.к. у yandex нет привязки внутреннего и внешнего IP, а на GCP у меня давно уже кончился триал период. А Vagrant  слишком долго траблшутить на моём железе и интернет-канале.
В роли `web` настраивается wordpress + selinux

## Запуск стенда
```
git clone https://github.com/NickVG/hl-linux-2021.git
cd 05-Nginx/terraform
terraform apply
cd ../ansible
echo "Need to wait VMs startup"
sleep 20
ansible-playbook setup_balance.yml
```
