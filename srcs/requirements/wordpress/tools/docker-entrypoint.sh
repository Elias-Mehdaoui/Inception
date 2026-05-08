#!/bin/sh

set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
WP_CREDS=$(cat /run/secrets/credentials)
WP_USER=$(echo $WP_CREDS | cut -d ':' -f 1)
WP_PASSWORD=$(echo $WP_CREDS | cut -d ':' -f 2)

while ! mariadb -h mariadb -u $MYSQL_USER -p$DB_PASSWORD $MYSQL_DATABASE -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
done

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root

    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb:3306 \
        --allow-root

    wp core install \
        --url=https://$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_USER \
        --admin_password=$WP_PASSWORD \
        --admin_email=admin@$DOMAIN_NAME \
        --allow-root

    wp user create standard_user user@$DOMAIN_NAME --role=author --user_pass=StandardUser123! --allow-root
fi

chown -R nobody:nobody /var/www/html

echo "Starting PHP WordPress..."
exec php-fpm83 -F
