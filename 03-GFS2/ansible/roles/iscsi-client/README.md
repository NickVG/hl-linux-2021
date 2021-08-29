Role Name
=========
Role is designed to configure iscsi-client

Requirements
------------

iSCSI server is ready and running

Role Variables
--------------

Role iscsi-server is applied

Dependencies
------------


Example Playbook
----------------

	- name: Install iSCSI client
	  hosts: gfs2
	  become: true
	  roles:
	    - iscsi-client

License
-------

BSD

Author Information
------------------

Nikolay Gorbunov
