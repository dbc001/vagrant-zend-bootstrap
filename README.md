vagrant-zend-bootstrap
======================

A vagrant file and setup script for installing MySQL and Zend (for Apache/PHP 5.4) in an ubuntu vm.

# What, and more importantly, why?
This repo includes a Vagrantfile and a bootstrap script to set up a vagrant-powered vm running ubuntu 12.04 32 bit with MySql and Zend Server installed.
* I know there are several ways to accomplish this including using Puppet or Chef, but I found this was the simplest and easiest to comprehend.
* If you haven't used Vagrant before you should check it out and get it installed here: http://www.vagrantup.com/
* By default we're using Ubuntu 12.04 32 bit simply because it seems to be the most widely used as a web server due to its stability and long term support. Feel free to change (lines 6-8 of the Vagrantfile) if you prefer something else.
* Zend Server simply provides a quick and easy way to install Apache and PHP, and has a nice web interface for some configuration stuff and performance monitoring. If you would rather install vanilla apache and php, feel free to replace lines 13-21 of bootstrap.sh with your own apache/php install commands.

# How do i do?
To get your fancy new server running, simply follow the following steps:
1. Make sure you have vagrant installed (including Virtualbox)
2. Put the 'Vagrantfile' and 'bootstrap.sh' files in your projects root directory.
3. Run the 'vagrant up' command.
4. Ta-da! Your project folder is now mounted as /vagrant (and symlinked to /var/www) inside your machine, and you can access it at the url 'localhost:8080'
5. You will also need to access 'localhost:10081' to do the Zend Server setup. Just follow the steps, and once you get to the main config, go to "Administration" and "License" to get your free license.

# Assorted Notes
* The internal ip to your new vm is '192.168.33.10'. Feel free to change it on line 19 of the Vagrantfile (but you will need to recreate it)
* The easiest way to access mysql directly is through phpMyAdmin, which should be installed.
* To connect with another mysql client (Sequel Pro, MySql Workbench, etc) use "SSH" settings and the ip listed above, and the ssh user "vagrant" with password "vagrant".
* 'AllowOverride All' is set for the doc root (/var/www) in /etc/apache2/sites-enabled/000-default (which is your main apache config file), because it is required for drupal's clean urls to work.
