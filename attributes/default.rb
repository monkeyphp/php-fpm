# php-fpm

default['php-fpm']['php-fpm']['pid']                         = '/var/run/php5-fpm.pid'
default['php-fpm']['php-fpm']['error_log']                   = '/var/log/php5-fpm.log'
default['php-fpm']['php-fpm']['syslog.facility']             = 'daemon'
default['php-fpm']['php-fpm']['syslog.ident']                = 'php-fpm'
default['php-fpm']['php-fpm']['log_level']                   = 'notice'
default['php-fpm']['php-fpm']['emergency_restart_threshold'] = 0
default['php-fpm']['php-fpm']['emergency_restart_interval']  = 0
default['php-fpm']['php-fpm']['process_control_timeout']     = 0
default['php-fpm']['php-fpm']['process.max']                 = 128
default['php-fpm']['php-fpm']['process.priority']            = -19
default['php-fpm']['php-fpm']['daemonize']                   = 'yes'
default['php-fpm']['php-fpm']['rlimit_files']                = 1024
default['php-fpm']['php-fpm']['rlimit_core']                 = 0
default['php-fpm']['php-fpm']['events.mechanism']            = 'epoll'
default['php-fpm']['php-fpm']['systemd_interval']            = 10
default['php-fpm']['php-fpm']['pool']['include']             = ['/etc/php5/fpm/pool.d/*.conf']

case node['platform']
when "centos"
    default['php-fpm']['php-fpm']['pid']             = '/var/run/php-fpm/php-fpm.pid'
    default['php-fpm']['php-fpm']['error_log']       = '/var/log/php-fpm/error.log'
    default['php-fpm']['php-fpm']['pool']['include'] = ['/etc/php-fpm.d/*.conf']
end

# www.conf
default['php-fpm']['www']['user']                      = 'www-data'
default['php-fpm']['www']['group']                     = 'www-data'
default['php-fpm']['www']['listen']                    = '/var/run/php5-fpm.sock'
default['php-fpm']['www']['listen.backlog']            = 128
default['php-fpm']['www']['listen.owner']              = 'www-data'
default['php-fpm']['www']['listen.group']              = 'www-data'
default['php-fpm']['www']['listen.mode']               = 0666
default['php-fpm']['www']['listen.allowed_clients']    = '127.0.0.1'
default['php-fpm']['www']['priority']                  = -19
default['php-fpm']['www']['pm']                        = 'dynamic'
default['php-fpm']['www']['pm.max_children']           = 5
default['php-fpm']['www']['pm.start_servers']          = 2
default['php-fpm']['www']['pm.min_spare_servers']      = 1
default['php-fpm']['www']['pm.max_spare_servers']      = 3
default['php-fpm']['www']['pm.idle_process_timeout']   = '10s'
default['php-fpm']['www']['pm.max_requests']           = 500
default['php-fpm']['www']['pm.status_path']            = '/status'
default['php-fpm']['www']['ping.path']                 = '/ping'
default['php-fpm']['www']['ping.response']             = 'pong'
default['php-fpm']['www']['access.log']                = 'log/$pool.access.log'
default['php-fpm']['www']['access.format']             = '"%R - %u %t \"%m %r%Q%q\" %s %f %{mili}d %{kilo}M %C%%"'
default['php-fpm']['www']['slowlog']                   = 'log/$pool.log.slow'
default['php-fpm']['www']['request_slowlog_timeout']   = 0
default['php-fpm']['www']['request_terminate_timeout'] = 0
default['php-fpm']['www']['rlimit_files']              = 1024
default['php-fpm']['www']['rlimit_core']               = 0
default['php-fpm']['www']['chroot']                    =  ''
default['php-fpm']['www']['chdir']                     = '/'
default['php-fpm']['www']['catch_workers_output']      = 'yes'
default['php-fpm']['www']['security.limit_extensions'] = '.php'

case node['platform']
when "centos"
    default['php-fpm']['www']['user']     = 'apache'
    default['php-fpm']['www']['group']    = 'apache'
    default['php-fpm']['www']['slowlog']  = '/var/log/php-fpm/$pool-slow.log'
    default['php-fpm']['www']['listen.owner']              = 'nginx'
    default['php-fpm']['www']['listen.group']              = 'nginx'
end
