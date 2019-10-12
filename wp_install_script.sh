#!/usr/bin/expect -f

clear
# set your variables here
echo "**********************************************"
echo "Welcome to Automated installation of Wordpress"
echo "**********************************************"
echo "Date and Time:" $(date +%F_%R)
echo "Sever Uptime is:" && uptime
sleep 2
echo "This Script install Wordpress automatically by creating a new database."
echo "This script assumes that Mysql 5.6 db on Debian9."
echo "Your MySQL Version:"
mysql_ver="$(mysql --version|awk '{ print $5 }'|awk -F\, '{ print $1 }')"
echo "MySQL Version is : $mysql_ver"
echo  "___________________________________________________________"
read -p "Enter your webroot (ex- /var/www/html): " webroot
#webroot=/var/www/html
read -p "Enter your root password of DB: " MYSQL_PASS


mysql -u root -p$MYSQL_PASS -e"exit"
if [ $? -eq 0 ]; then
    echo "Mysql-root password is correct... Logging in.."
else
    echo "Please check your msyql-root credentials"
     exit 1
fi
sleep 1
apt-get install net-tools wget zip unzip curl git pv ed expect -y 
echo "---------------------------------------------------"
echo "Server Information"
echo "----------------------------------------------------"
lsb_release –ds 
hostnamectl
echo "Running service  information"
echo "***************************************************"
service --status-all 
netstat -tulnp
$SHELL –version  
sleep 1
echo "---------------------------------------------------"
echo "MySQL Information..."
echo "----------------------------------------------------"
mysqladmin -u root -p$MYSQL_PASS ping
mysqladmin -u root -p$MYSQL_PASS version
mysqladmin -u root -p$MYSQL_PASS status


#we are generating databasename and username from /dev/urandom command. 
dbname=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '');

#we are generating username from openssl command
dbuser=$(openssl rand -base64 12 | tr -dc A-Za-z | head -c 8 ; echo '')

#Openssl is another way to generating 64 characters long password)
#dbpass=$(openssl rand -hex 8); #It generates max 16 digits password we can also use this for all above process.

dbpass=$(openssl rand -base64 12 | tr -dc A-Za-z | head -c 12 ; echo '')



if [ $? -eq 0 ]; then
    echo "Wordpress DB credenetials successfully."
else
    echo "Wordpress DB credentials generation failed"
     exit 1
fi
sleep 1


echo "------------------------DB setup started-----------------------------------"
Q1="CREATE DATABASE IF NOT EXISTS $dbname;"
Q2="GRANT USAGE ON *.* TO $dbuser@localhost IDENTIFIED BY '$dbpass';"
Q3="GRANT ALL PRIVILEGES ON $dbname.* TO $dbuser@localhost;"
Q4="FLUSH PRIVILEGES;"
Q5="SHOW DATABASES;"	
SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"
  
mysql -uroot -p$MYSQL_PASS -e "$SQL" && echo "DB Creation done" || echo "DB Creation failed"
sleep 1

cd $webroot
if [ -z "$(ls -A $webroot)" ]; then

   echo "$webroot is Empty"

else

   echo "There are some files in the $webroot"
   echo "Zipping old files with lastbackup.zip, this can be found in webroot directory"
   cd $webroot
#  rm -rf lastbackup.zip
   zip -q lastbackup.zip $webroot/* .*
   mv -f lastbackup.zip ../
#  rm -rfv !{"lastbackup.zip"}
   rm -rf .*
   rm -rf *

fi

sleep 1
curl -O https://wordpress.org/latest.tar.gz
echo "Downloading ....................................."
echo "      "
tar -xf latest.tar.gz
#pv latest.tar.gz | tar xzf - -C .
cd wordpress
cp -rf . ..
cd ..
git clone https://github.com/ajaykumar011/wordpress-config.git
cp wordpress-config/wp-config.php .
rm -rf wordpress-config
rm -R wordpress
echo "------------------------------------------"
echo "Autogenrated DB Info:"
echo "------------------------------------------"
echo "DB Name: $dbname"
echo "DB User: $dbuser"
echo "DB Pwd : $dbpass"
echo "Host   : localhost"
echo "------------------------------------------"

perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php

#Salt configuration section

SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
STRING='put your unique phrase here'
printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s wp-config.php


echo "<?php phpinfo();?>" > $webroot/info.php
echo "We are implementing the permission ftpuser:www-data for /var/www folder"
sudo chown -R ftpuser:www-data /var/www
sudo chmod 2775 /var/www
sudo find /var/www -type d -exec chmod 2775 {} \;
sudo find /var/www -type f -exec chmod 0664 {} \;

sleep 1
if [ $? -eq 0 ]; then
    echo "Wordpress DB configuration done successfully."
else
    echo "Wordpress DB configuration failed"
fi
wp_ver="$(grep wp_version wp-includes/version.php | awk -F "'" '{print $2}')"
echo "Your WP Version is $wp_ver"

rm latest.tar.gz
echo "******************************************************"
echo Server Information
echo "******************************************************"
curl -I localhost
echo "=========================================================="
echo "Installation is finished. "
echo "=========================================================="
echo "$(tput setaf 7)$(tput setab 6)---|-WP READY TO ROCK-|---$(tput sgr 0)"

#apt-get install python-pip glances -y
#pip install --upgrade glances
#glances
