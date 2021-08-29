# ДЗ по теме GFS2

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
gfs2.tf - описание узлов для gfs2
vpc.tf - описание сети
iscsi-server.tf - описание iscsi-server
outputs.tf - вывод IP ВМ, а также создание динамического inventory для ansible + файл hosts
terraform.tfvars - присвоение значений переменным, которое не публикуется на git исходя из соображений безопасности.
Вместо него можно ознакомится с файлом terraform.tfvars.example
inventory.tmpl - темплейт для формирование динамического inventory для ansible
hosts.tmpl - темплейт для формирование динамического inventory и файла hosts
variables.tf - объявление переменных
```

Вторая часть состоит из пьесы `cluster_setup.yml`, которая запускает роли `iscsi-server` `iscsi-client` `iscsi-initiators` `pcm-setup` и `gfs2`


## Запуск стенда
```
git clone https://github.com/NickVG/hl-linux-2021.git
cd 03-GFS2/terraform
terraform apply
cd ../ansible
echo "Need to wait VMs startup"
sleep 20
ansible-playbook cluster_setup.yml
```
