#!/usr/bin/env bash

sudo groupadd admin
sudo usermod -G admin vagrant
sudo apt-get update

# Install mysql first to prevent issues with zend
# Password 'root' will be set.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

# Add zend repo and install zend server
echo "deb http://repos.zend.com/zend-server/6.2/deb_ssl1.0 server non-free" >> /etc/apt/sources.list
wget http://repos.zend.com/zend.key -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install zend-server-php-5.4

# Zend server stuff
echo "PATH=$PATH:/usr/local/zend/bin" >> ~/.bashrc

# Allow mysql connections from other than localhost
echo "%s,bind-address\t\t= 127.0.0.1,# bind-address\t\t= 127.0.0.1,g
w
q
" | sudo ex /etc/mysql/my.cnf

# Allow override all, required for drupal clean urls.
echo "s,AllowOverride None,AllowOverride All,g
w
q
" | sudo ex +15 /etc/apache2/sites-enabled/000-default

# Install debconf-utils so we can set the phpmyadmin install parameters
sudo apt-get -y install debconf-utils

# Set a bunch of parameters needed for the phpmyadmin install
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

# Install phpmyadmin quietly
sudo apt-get -q -y install phpmyadmin

# As part of the phpmyadmin install, we include its conf file in the main apache conf
sudo sed -i '$a Include /etc/phpmyadmin/apache.conf' /etc/apache2/apache2.conf

# Lets increase the auto logout time for phpmyadmin (since we're only using this script for
# a development environment... right?) to something like 5.7 days.
sudo sed -i '$a // Bootstrap.sh here, just increasing the auto logout time for phpmyadmin.' /etc/phpmyadmin/config.inc.php
sudo sed -i '$a $cfg['\''LoginCookieValidity'\''] = 500000;' /etc/phpmyadmin/config.inc.php

# Restart apache and let the world know we've finished.
sudo service apache2 restart
echo "Bootstrap.sh all done"
