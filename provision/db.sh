### Create MySQL database symfony
mysql -u root -pmysql -e "CREATE DATABASE IF NOT EXISTS sso;"

### Add dba user allow connect from anywhere to MySQL
mysql -u root -pmysql -e "CREATE USER 'dba'@'%' IDENTIFIED BY 'Y88dHbrXYj'; FLUSH PRIVILEGES;"

### Grant all privileges on symfony database
mysql -u root -pmysql -e "GRANT ALL PRIVILEGES ON sso.* TO 'dba'@'%'; FLUSH PRIVILEGES;"
