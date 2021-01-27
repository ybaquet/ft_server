echo "+------------------+"
echo "| init_database.sh |"
echo "+------------------+"

echo "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword';"  | mysql -u root --skip-password
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

if [ "$AUTOINDEX" = "OFF" ]
then
	chmod +w  /etc/nginx/sites-available/default
	sed -i 's/autoindex on;/autoindex off;/g' /etc/nginx/sites-available/default
fi

