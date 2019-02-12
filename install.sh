#!/bin/bash

cd /var/www/html
echo "=================Create Laravel Projek==================="
composer create-project --prefer-dist laravel/laravel projek
sudo chmod -R 755 /var/www/html/projek/
sudo chown -R www-data:www-data /var/www/html/projek/storage
echo "=================Configurasi Nginx==================="
sudo cp laravnginx /etc/nginx/sites-available/

sudo ln -s /etc/nginx/sites-available/laravnginx /etc/nginx/sites-enabled/
sudo systemctl restart nginx.service

echo "=================Optimize==================="
cd /var/www/html/projek
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache

echo "=================Add Vhosts==================="
sudo sh -c 'echo "127.0.1.1  projek.test" >> /etc/hosts'
echo "=================Done==================="