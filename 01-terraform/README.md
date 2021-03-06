# ДЗ по теме terraform

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
app.tf - описание запускаемой VM и сети
outputs.tf - вывод IP ВМ, а также создание динамического inventory для ansible
terraform.tfvars - присвоение значений переменным, которое не публикуется на git исходя из соображений безопасности.
Вместо него можно ознакомится с файлом terraform.tfvars.example
inventory.tmpl - темплейт для формирование динамического inventory для ansible
variables.tf - объявление переменных
```

Вторая часть состоит из роли `nginx_new.yml`, которая запускает роли `nginx` и `mkrepo`

## Запуск стенда
```
git clone https://github.com/NickVG/hl-linux-2021.git
cd 01-terraform/terraform
terraform apply
cd ../ansible
ansible-playbook nginx_new.yml
```
