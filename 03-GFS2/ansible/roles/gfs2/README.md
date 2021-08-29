Role Name
=========

A brief description of the role goes here.

Requirements
------------

PCM Cluster should be up and running
Such roles as:

	iscsi-client
	iscsi-initiators
	iscsi-server
	pcm-setup

should be already applied

Role Variables
--------------

List of variables:

	# Имя PCM кластера
	pacemaker_hacluster_name: 'hacluster'
	# Число узлов в кластере
	hosts_in_cluster: '3'

Variables are in file defaults/main.yml

Dependencies
------------

No dependecies

Example Playbook
----------------

	- name: Configure gfs2
	  hosts: gfs2_master
	  become: true
	  roles:
	    - gfs2

License
-------

BSD

Author Information
------------------

Nikolay Gorbunov
