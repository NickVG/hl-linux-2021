mysql   <<EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
GRANT ALL ON wordpress.* TO 'wordpressuser'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF
