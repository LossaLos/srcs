#!/bin/sh

if [ -f ./wp-config.php ]
then
    echo "wordpress already downloaded"
else
    # dl wp
    php -r "file_put_contents('wordpress-6.5.5.tar.gz', file_get_contents('https://wordpress.org/wordpress-6.5.5.tar.gz', false, stream_context_create(['ssl' => ['verify_peer' => false, 'verify_peer_name' => false]])));"
    tar xfz wordpress-6.5.5.tar.gz
    mv wordpress/* .
    rm -rf wordpress-6.5.5.tar.gz
    rm -rf wordpress

    # Import var on conf
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
    sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php

    # add security key
    php -r "
    \$config = file_get_contents('wp-config.php');
    \$secret_keys = file_get_contents('https://api.wordpress.org/secret-key/1.1/salt/', false, stream_context_create(['ssl' => ['verify_peer' => false, 'verify_peer_name' => false]]));
    \$config = str_replace('/* That\'s all, stop editing! Happy publishing. */', \$secret_keys . PHP_EOL . '/* That\'s all, stop editing! Happy publishing. */', \$config);
    file_put_contents('wp-config.php', \$config);
    "

    # add url to wp conf
    echo "define('WP_HOME', '$WP_URL');" >> wp-config.php
    echo "define('WP_SITEURL', '$WP_URL');" >> wp-config.php

    # cahnge workdir perm
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html

    echo "Waiting for MySQL to be ready..."
    sleep 5

    # load wp db
    php -r "
    define('WP_INSTALLING', true);
    require_once 'wp-load.php';
    require_once 'wp-admin/includes/upgrade.php';
    wp_install('$WP_TITLE', '$WP_ADMIN_USER', '$WP_ADMIN_EMAIL', true, '', '$WP_ADMIN_PASSWORD');
    wp_create_user('$WP_USER', '$WP_USER_PASSWORD', '$WP_USER_EMAIL');
    " 2>/dev/null
	echo "Wordpress ready."
fi

exec "$@"