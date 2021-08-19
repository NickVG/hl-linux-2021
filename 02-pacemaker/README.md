# Занятие по теме  Pacemaker

##Краткая инструкция по запуску 2х узлового кластера NGINX на базе Pacemaker и CentOS

0. Prerequisites

   - наличие DNS или записи в /etc/hosts
   - 
   В данном случае используются следующие имена узлов кластера:
  ha-node1
  ha-node2

1. Устанавливаем и запускаем необходимые компоненты

``` yum install -y pacemaker pcs resource-agents corosync nginx fence-agents-all.x86_64
    systemctl enable pcsd.service; sudo systemctl start pcsd.service
```
2. При установке pacemaker создаёт пользователя haclaster. Зададим ему пароль

``` passwd hacluster
 
3. Авторизуем pacemaker на всех нодах с помощью УЗ haclaster

``` pcs cluster auth ha-node1 ha-node2 -u hacluster

4. Создаём 2х узловой кластер

``` pcs cluster setup --force --name NGINXCLUSTER ha-node1 ha-node2
    pcs cluster status

5. Выключаем stonith и кворум для 2х узлового кластера

``` pcs property set no-quorum-policy=ignore
``` pcs property set stonith-enabled=false

6. Создаём кластерные ресурсы

``` pcs resource create cluster_ip ocf:heartbeat:IPaddr2 ip=192.168.11.100 cidr_netmask=24 op monitor interval=30s
``` pcs resource create nginx ocf:heartbeat:nginx op monitor interval=30s timeout=30s
```  cluster cluster status

7. Группируем кластерный IP и nginx

``` pcs resource group add nginx_cluster nginx  cluster_ip
``` sudo pcs resource group add nginx_cluster nginx --after cluster_ip

Также можно создать следующее правило:

``` pcs constraint colocation add cluster_ip nginx INFINITY
``` pcs constraint order cluster_ip then nginx
