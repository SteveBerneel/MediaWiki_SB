# !/bin/bash -eu
# provision.sh -- Install Apache, a test PHP script and MediaWiki

# Install EPEL
sudo yum install -y http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#sudo rpm -ivh epel-release-6-8.noarch.rpm

# Install Apache, PHP, mysql, mysql-server, mediawiki119
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
yum install -y httpd php mysql mysql-server gd gd-devel php-gd php-pecl-apc mediawiki119 vsftpd

# Start the services
service httpd start
chkconfig httpd on
sudo service mysqld start
sudo chkconfig mysqld on
sudo service vsftpd start
sudo chkconfig vsftpd on 

# Write a test script
cat > /var/www/html/index.php << EOF
<?php phpinfo(); ?>
EOF

db_root_pw2='thi1313'
db_root_pw=thi1313
mw_db_usr=wikiuser
mw_db_pw=dhinn0liz13z
mediawiki_dir=/var/www/html/mediawiki
mediawiki_db=mediawiki
mediawiki_usr=wikiadmin
mediawiki_pw=fiskeug5redhinn0lizkawf7

sudo /usr/bin/mysqladmin -u root password $db_root_pw2

sudo ln -s /var/www/mediawiki119 $mediawiki_dir 
sudo chown -R apache:apache $mediawiki_dir  
mysql -u root --password=$db_root_pw -e 'create database mediawiki' 
mysql -u root --password=$db_root_pw -e "grant index, create, select, insert, update, delete, alter, lock tables on mediawiki.* to 'wikiuser'@'localhost' identified by 'dhinn0liz13z'";
mysql -u root --password=$db_root_pw -e 'drop database test'
mysql -u root --password=$db_root_pw -e 'delete from mysql.user where user=""'
mysql -u root --password=$db_root_pw -e 'flush privileges'
sudo service httpd restart

# Execute the mediawiki maintenance/install.php script
sudo php /var/www/html/mediawiki/maintenance/install.php --dbname $mediawiki_db --dbpass $mw_db_pw --dbserver localhost --dbtype mysql --dbuser $mw_db_usr --confpath /var/www/html/mediawiki --installdbpass $db_root_pw --installdbuser root --pass $mediawiki_pw --lang en --scriptpath /mediawiki --server "http://192.168.56.65"  First_Wiki $mediawiki_usr

cat << _EOF_
-------------------------------------------------------------------------
 MEDIAWIKI INSTALLATION COMPLETED!
 For more info please see the Readme.md file on 
  https://github.com/SteveBerneel/MediaWiki_SB
--------------------------------------------------------------------------
_EOF_









