#
# Cookbook Name:: php-fpm
# Recipe:: default
#
# Copyright 2014, David White
#
# All rights reserved - Do Not Redistribute
#
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
