if [ ! -f /var/www/html/install.lock ]; then
    wait-for-it klump_mysql:3306 -t 60 &&
    cp config-dist.php config.php
    cp admin/config-dist.php admin/config.php
    php /var/www/html/install/cli_install.php install --username admin --password admin --email email@example.com --http_server http://localhost:8080/ --db_driver mysqli --db_hostname klump_mysql --db_username user --db_password password --db_database opencart --db_port 3306 --db_prefix oc_;
    touch /var/www/html/install.lock;
fi && apache2-foreground