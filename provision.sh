# !/bin/bash -eu
# provision.sh -- Install Apache and a test PHP script

# Install Apache and PHP
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
yum install -y httpd php

# Start the service
service httpd start
chkconfig httpd on

# Write a test script
cat > /var/www/html/index.php << EOF
<?php phpinfo(); ?>
EOF


# Install MySQL 
echo -------------------------------------------
echo Installing MySQL ....
echo -------------------------------------------
sudo yum install -y mysql mysql-server
echo -------------------------------------------
echo MySQL installed 
echo -------------------------------------------
echo start MYSQLD service and run at startup
echo -------------------------------------------
sudo service mysqld start
sudo chkconfig mysqld on
echo -------------------------------------------
echo service mysqld started and running at startup
echo -------------------------------------------
echo Setting password ...
echo -------------------------------------------
sudo /usr/bin/mysqladmin -u root password 'thi1313'
echo -------------------------------------------
echo *******************************************
echo MYSQL MYSQL-SERVER INSTALLATION COMPLETED!
echo *******************************************
echo -------------------------------------------


# Install MEDIAWIKI
# Install Pre-requisites
# Install EPEL
sudo wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -ivh epel-release-6-8.noarch.rpm
# Install gd gd-devel php-gd php-pecl-apc
sudo yum install -y gd gd-devel php-gd php-pecl-apc
#Install vsftpd
sudo yum install -y vsftpd
sudo service vsftpd start
sudo chkconfig vsftpd on 
#Install nano
sudo yum install -y nano
#Install MediaWIKI
sudo yum install -y mediawiki119
sudo ln -s /var/www/mediawiki119 /var/www/html/mediawiki 
sudo chown -R apache:apache /var/www/html/mediawiki  
mysql -u root --password=thi1313 -e 'create database mediawiki' 
mysql -u root --password=thi1313 -e "grant index, create, select, insert, update, delete, alter, lock tables on mediawiki.* to 'wikiuser'@'localhost' identified by 'password'";
mysql -u root --password=thi1313 -e 'flush privileges'
sudo service httpd restart
echo -------------------------------------------------------------------------
echo MEDIAWIKI INSTALLATION ALMOST COMPLETED!
echo Please go to http://192.168.56.65/mediawiki to set up the wiki!!!!!!!!!!!
echo For more info please see the Readme.md file on 
        https://github.com/SteveBerneel/MediaWiki_SB
echo --------------------------------------------------------------------------

echo END OF SCRIPT








