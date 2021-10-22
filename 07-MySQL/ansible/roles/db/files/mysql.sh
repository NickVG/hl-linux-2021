mysql -u root --password=$(grep "temporary" /var/log/mysqld.log|cut -d " " -f 13) --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '123qweASD+';" > /dev/null 2>&1

mysql -u root --password='123qweASD+' <<EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
create user 'wordpressuser'@'%' IDENTIFIED BY 'P@ssw0rd';
GRANT ALL ON wordpress.* TO 'wordpressuser'@'%';
FLUSH PRIVILEGES;
EOF

