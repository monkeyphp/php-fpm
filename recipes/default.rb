#
# Cookbook Name:: php-fpm
# Recipe:: default
#
# Copyright 2014, David White
#
# All rights reserved - Do Not Redistribute
#
case node["platform"]
    
when "centos"
    
    remote_file "#{Chef::Config[:file_cache_path]}/epel-release-6-8.noarch.rpm" do
        source "http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
        mode 0777
        action :create_if_missing
        backup false
    end
    
    remote_file "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm" do
        source "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
        mode 0777
        action :create_if_missing
        backup false
    end
    
    package "epel-release-6-8.noarch.rpm" do
        source "#{Chef::Config[:file_cache_path]}/epel-release-6-8.noarch.rpm"
        provider Chef::Provider::Package::Rpm
        action :install
    end
    
    package "remi-release-6.rpm" do
        source "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm"
        provider Chef::Provider::Package::Rpm
        action :install
    end
    
    package "php-common" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end
    
    package "php-fpm" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end
    
    package "php-mysqlnd" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end
    
    package "php-opcache" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end
    
    package "php-devel" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end
    
    package "php-intl" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end
    
    package "php-xml" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end

    package "php-soap" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end

    package "php-mbstring" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end

    package "memcached" do
        action :install
    end

    package "php-memcached" do
        options "--enablerepo=remi,remi-php55"
        action :install
    end

    bash "install_xdebug" do
        user "root"
        code "pecl install xdebug"
        not_if "pecl list | grep -w xdebug"
    end

    file "/etc/php.d/xdebug.ini" do
        owner "root"
        group "root"
        mode "0644"
        content "[xdebug]\nzend_extension=\"/usr/lib64/php/modules/xdebug.so\"\nxdebug.remote_enable = 1\n"
        action :create_if_missing
    end

    remote_file "/tmp/2.2.5.tar.gz" do
        source "https://github.com/nicolasff/phpredis/archive/2.2.5.tar.gz"
        mode 0777
        action :create_if_missing
        backup false
    end
    
    bash 'build_phpredis' do
        user "root"
        code <<-EOH
            tar xf /tmp/2.2.5.tar.gz 
            cd ./phpredis-2.2.5
            phpize
            ./configure
            make
            sudo make install
            sudo echo "extension=redis.so" > /etc/php.d/redis.ini
        EOH
    end
    
    service "php-fpm" do
        supports :start => true, :stop => true, :status => true, :restart => true, :reload => true
        action :nothing
    end
    
    template "/etc/php-fpm.conf" do 
        source   "php-fpm.conf.erb"
        owner    "root"
        group    "root"
        mode     0644
        notifies :reload, resources(:service => "php-fpm")
    end
    
    template "/etc/php-fpm.d/www.conf" do 
        source   "pool.d/www.conf.erb"
        owner    "root"
        group    "root"
        mode     0644
        notifies :reload, resources(:service => "php-fpm")
    end
    
    service "php-fpm" do
        action :start
    end
 
when "ubuntu"
    
    package "php5-common" do
        action :install    
    end

    package "php5-fpm" do
        action :install    
    end

    service "php5-fpm" do
        supports :start => true, :stop => true, :status => true, :restart => true, :reload => true
        action :nothing
    end

    template "/etc/php5/fpm/php-fpm.conf" do 
        source   "php-fpm.conf.erb"
        owner    "root"
        group    "root"
        mode     0644
        notifies :reload, resources(:service => "php5-fpm")
    end

    template "/etc/php5/fpm/pool.d/www.conf" do 
        source   "pool.d/www.conf.erb"
        owner    "root"
        group    "root"
        mode     0644
        notifies :reload, resources(:service => "php5-fpm")
    end    

end
