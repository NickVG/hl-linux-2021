# Описание

Стенд для практики к уроку «Terraform.»  

Разворачивается сервер: `nginx`. 

# Инструкция по применению
## Перед запуском
Требуется устнаовить git, ansible.
Основано на ДЗ к курсе Linux
```bash
git clone https://github.com/NickVG/hl-linux-2021.git
cd 01-terraform/terraform
terraform apply
cd ../ansible
```
Все дальнейшие действия нужно делать из текущего каталога.

## Запускаем и работаем со стендом

После запуска ВМ с помощью терраформа необходимо запустить роль:

Запустим роль: `ansible-playbook nginx_new.yml`  
Так выглядит основной playbook `nginx_new.yml`, который уже в свою очередь ссылается на роли `nginx` и `mkrepo`:

```yml
---
- name: Install nginx && create repo
  hosts: nginx
  become: true
  roles:
    - nginx 
    - mkrepo
```
Роль `nginx` поднимает вебсервер на центос.
Роль `mkrepo` создаёт репозиторий.

# список тасков в ролях

Посмотреть все таски, которые входят в роль:
```bash
ansible-playbook nginx_new.yml --list-tasks
playbook: nginx_new.yml

  play #1 (host1): Install EPEL Repo	TAGS: []
    tasks:
      nginx : Install NGINX	TAGS: []
      nginx : configure Nginx	TAGS: []
      nginx : Disable selinux	TAGS: []
      mkrepo : Install Packages	TAGS: []
      mkrepo : configure Nginx for repo	TAGS: []
      mkrepo : configure repo	TAGS: []
```
