#!/bin/bash
cd /usr/share/nginx/html/wordpress/
git clone https://github.com/kevinoid/postgresql-for-wordpress.git
mv postgresql-for-wordpress/pg4wp pg4wp
rm -rf postgresql-for-wordpress
cp Pg4wp/db.php db.php
