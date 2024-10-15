#!/bin/sh

# Attendre que la base de données soit prête
sleep 8

echo "MariaDB is up - executing command"

# Vérifier si WordPress est déjà installé
if ! wp core is-installed --allow-root; then
    # Configurer wp-config.php
    wp config create --allow-root \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST%%:*}"
    
    # Installer WordPress
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Mon Site WordPress" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"
    
    # Créer un utilisateur supplémentaire
    wp user create --allow-root \
        "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}"
fi

# Transférer le contrôle à la commande CMD
exec "$@"
