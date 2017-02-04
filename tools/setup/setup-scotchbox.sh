# Script to setup the dexonline development environment on a ScotchBox VM 
#
# Important: The script must be ran with sudo rights
# How to setup the VM: https://git.io/vDcOb

mysql -u root -p  -e "create database dexonline character set utf8" scotchbox
mkdir /var/www/public
cd /var/www/public
git clone https://github.com/dexonline/dexonline dexonline
cd dexonline
/bin/bash tools/setup.sh
wget -O /tmp/dex-database.sql.gz https://dexonline.ro/static/download/dex-database.sql.gz
zcat /tmp/dex-database.sql.gz | mysql -u root -p dexonline
php tools/migration.php
